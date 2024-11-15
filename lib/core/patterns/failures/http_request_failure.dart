import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_request_failure.freezed.dart';

@freezed
class HttpRequestFailure with _$HttpRequestFailure {
  const factory HttpRequestFailure.network() = _Network;
  const factory HttpRequestFailure.notFound() = _NotFound;
  const factory HttpRequestFailure.server() = _Server;
  const factory HttpRequestFailure.unauthorized() = _Unauthorized;
  const factory HttpRequestFailure.forbidden() = _Forbidden;
  const factory HttpRequestFailure.badRequest() = _BadRequest;
  const factory HttpRequestFailure.local() = _Local;

  factory HttpRequestFailure.fromCode(int? code) {
    if (code == null) return const HttpRequestFailure.badRequest();

    if (code >= 500) return const HttpRequestFailure.server();

    if (code == 404) return const HttpRequestFailure.notFound();

    if (code == 401) return const HttpRequestFailure.unauthorized();

    if (code == 403) return const HttpRequestFailure.forbidden();

    return const HttpRequestFailure.local();
  }

  factory HttpRequestFailure.fromException(Object e) {
    if (e is HttpRequestFailure) return e;
    if (e is DioException) {
      if (e.type == DioExceptionType.badResponse) {
        return HttpRequestFailure.fromCode(e.response?.statusCode);
      }
      return const HttpRequestFailure.network();
    }
    return const HttpRequestFailure.local();
  }
}
