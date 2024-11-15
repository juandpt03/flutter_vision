import 'package:flutter_vision/core/core.dart';
import 'package:flutter_vision/features/home/infrastructure/models/chat_completion_request.dart';
import 'package:flutter_vision/features/home/infrastructure/models/chat_completion_response.dart';

abstract class ApiDatasource {
  Future<Either<HttpRequestFailure, ChatCompletionResponse>> applyVision({
    required ChatCompletionRequest request,
  });
}
