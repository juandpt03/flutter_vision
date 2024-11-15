import 'package:flutter_vision/core/patterns/either/either.dart';
import 'package:flutter_vision/core/patterns/failures/http_request_failure.dart';
import 'package:flutter_vision/features/home/infrastructure/models/chat_completion_request.dart';
import 'package:flutter_vision/features/home/infrastructure/models/chat_completion_response.dart';

abstract class ApiRepository {
  Future<Either<HttpRequestFailure, ChatCompletionResponse>> applyVision({
    required ChatCompletionRequest request,
  });
}
