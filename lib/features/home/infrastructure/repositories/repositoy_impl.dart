import 'package:flutter_vision/core/patterns/either/either.dart';
import 'package:flutter_vision/core/patterns/failures/http_request_failure.dart';
import 'package:flutter_vision/features/home/domain/repositories/api_repository.dart';
import 'package:flutter_vision/features/home/infrastructure/datasources/open_ai_datasource.dart';
import 'package:flutter_vision/features/home/infrastructure/models/chat_completion_request.dart';
import 'package:flutter_vision/features/home/infrastructure/models/chat_completion_response.dart';

class RepositoyImpl extends ApiRepository {
  final OpenAiDatasource datasource;

  RepositoyImpl({required this.datasource});
  @override
  Future<Either<HttpRequestFailure, ChatCompletionResponse>> applyVision(
          {required ChatCompletionRequest request}) =>
      datasource.applyVision(request: request);
}
