import 'package:dio/dio.dart';
import 'package:flutter_vision/core/core.dart';
import 'package:flutter_vision/features/home/domain/repositories/api_repository.dart';
import 'package:flutter_vision/features/home/infrastructure/datasources/open_ai_datasource.dart';
import 'package:flutter_vision/features/home/infrastructure/repositories/repositoy_impl.dart';
import 'package:flutter_vision/features/shared/shared.dart';
import 'package:image_picker/image_picker.dart';

class DI {
  DI._internal();
  static final DI instance = DI._internal();
  static final ServiceLocator serviceLocator = ServiceLocator();

  factory DI() => instance;

  Future<void> setup() async {
    await EnvLoader().loadEnv('.env');

    serviceLocator.register(EnvLoader());
    serviceLocator.register(AppTheme());
    serviceLocator.register(TransitionManager());
    serviceLocator.register<ImagePicker>(ImagePicker());
    serviceLocator.register<Dio>(Dio(
      BaseOptions(
        contentType: 'application/json',
        baseUrl: baseUrl,
      ),
    ));
    serviceLocator.register<OpenAiDatasource>(
      OpenAiDatasource(dio: serviceLocator.get()),
    );
    serviceLocator.register<RepositoyImpl>(
      RepositoyImpl(datasource: serviceLocator.get()),
    );

    serviceLocator.register<ApiRepository>(
      serviceLocator.get<RepositoyImpl>(),
    );
  }
}
