import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_vision/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/features/shared/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final di = DI();

  await di.setup();
  runApp(
    ProviderScope(
      observers: [ProviderStateLogger()],
      child: MultiObserver(
        observers: [
          (context, child) => LanguageObserver(child: child),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sl = ServiceLocator();
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: sl.get<AppTheme>().lightTheme,
      darkTheme: sl.get<AppTheme>().darkTheme,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
    );
  }
}
