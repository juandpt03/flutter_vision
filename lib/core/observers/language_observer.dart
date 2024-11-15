import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/features/shared/shared.dart';

class LanguageObserver extends ConsumerStatefulWidget {
  final Widget child;

  const LanguageObserver({super.key, required this.child});

  @override
  LanguageObserverState createState() => LanguageObserverState();
}

class LanguageObserverState extends ConsumerState<LanguageObserver>
    with WidgetsBindingObserver {
  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    if (locales != null && locales.isNotEmpty) {
      Locale newLocale = locales.first;
      ref.read(languageProvider.notifier).updateLocale(newLocale);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(languageProvider.notifier)
          .updateLocale(WidgetsBinding.instance.platformDispatcher.locale);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
