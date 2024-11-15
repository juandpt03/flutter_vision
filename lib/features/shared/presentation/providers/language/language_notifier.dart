import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(PlatformDispatcher.instance.locale);

  void updateLocale(Locale newLocale) {
    if (state != newLocale) {
      state = newLocale;
    }
  }
}
