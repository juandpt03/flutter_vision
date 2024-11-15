import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_vision/core/core.dart';

import 'package:flutter_vision/features/home/domain/datasources/api_datasource.dart';
import 'package:flutter_vision/features/home/infrastructure/models/chat_completion_request.dart';
import 'package:flutter_vision/features/home/infrastructure/models/chat_completion_response.dart';

class OpenAiDatasource extends ApiDatasource {
  final Dio dio;

  OpenAiDatasource({required this.dio});
  @override
  Future<Either<HttpRequestFailure, ChatCompletionResponse>> applyVision(
      {required ChatCompletionRequest request}) async {
    try {
      final response = await dio.post(
        options: Options(headers: {
          'Authorization': 'Bearer ${Environment.instance.apikey}',
        }),
        'v1/chat/completions',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final chatCompletionResponse =
            ChatCompletionResponse.fromJson(response.data);
        log(chatCompletionResponse.choice.message.content);
        return Right(ChatCompletionResponse.fromJson(response.data));
      }

      throw HttpRequestFailure.fromCode(response.statusCode);
    } catch (e) {
      final failure = HttpRequestFailure.fromException(e);
      return Left(failure);
    }
  }
}
