import 'package:flutter_vision/core/core.dart';

class Environment {
  static final Environment instance = Environment._internal();
  static final EnvLoader _envLoader = ServiceLocator().get<EnvLoader>();

  Environment._internal();

  factory Environment() => instance;

  final apikey = _envLoader.get('API_KEY');
}
