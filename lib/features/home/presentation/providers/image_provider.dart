import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/core/core.dart';
import 'package:flutter_vision/features/home/domain/entities/ticket.dart';
import 'package:flutter_vision/features/home/domain/repositories/api_repository.dart';
import 'package:flutter_vision/features/home/infrastructure/models/chat_completion_request.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider = StateNotifierProvider<ImageNotifier, VisionState>((ref) {
  return ImageNotifier(
    picker: ServiceLocator().get<ImagePicker>(),
    repository: ServiceLocator().get<ApiRepository>(),
  );
});

class ImageNotifier extends StateNotifier<VisionState> {
  final ImagePicker _picker;
  final ApiRepository _repository;
  ImageNotifier({
    required ImagePicker picker,
    required ApiRepository repository,
  })  : _picker = picker,
        _repository = repository,
        super(VisionState());

  Future<void> setImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final path = File(image.path);

    state = state.copyWith(image: path);
  }

  Future<bool> applyVision() async {
    final image = state.image;
    if (image == null) false;

    final bytes = image!.readAsBytesSync();
    final base64 = base64Encode(bytes);

    final request = ChatCompletionRequest();
    request.addMessage(
      Message(
        role: 'user',
        content: [
          // ContentItem(
          //   type: 'text',
          //   text:
          //       'Please analyze this image and return the extracted information.',
          // ),
          ContentItem(
            type: 'image_url',
            imageUrl: ImageUrl(
              url: 'data:image/jpeg;base64,$base64',
            ),
          ),
        ],
      ),
    );
    final response = await _repository.applyVision(request: request);

    return response.when(
        left: (failure) => false,
        right: (response) {
          state = state.copyWith(ticket: response.choice.getTicket());
          return true;
        });
  }
}

class VisionState {
  final Ticket? ticket;
  final bool isLoading;
  final HttpRequestFailure? error;
  final File? image;

  VisionState({
    this.ticket,
    this.isLoading = false,
    this.error,
    this.image,
  });

  VisionState copyWith({
    Ticket? ticket,
    bool? isLoading,
    HttpRequestFailure? error,
    File? image,
  }) {
    return VisionState(
      ticket: ticket ?? this.ticket,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      image: image ?? this.image,
    );
  }
}
