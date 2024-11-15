import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_vision/core/core.dart';
import 'package:flutter_vision/features/auth/presentation/screens.dart';
import 'package:flutter_vision/features/shared/shared.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final transition = ServiceLocator().get<TransitionManager>();
  return GoRouter(
    routes: [
      GoRoute(
        path: HomeScreen.routeName,
        pageBuilder: (context, state) => transition.slideTransition(
          child: const HomeScreen(),
          state: state,
        ),
        name: HomeScreen.routeName,
      ),
      GoRoute(
        path: LoginScreen.routeName,
        pageBuilder: (context, state) => transition.slideTransition(
          child: const LoginScreen(),
          state: state,
        ),
        name: LoginScreen.routeName,
      )
    ],
    initialLocation: '/',
  );
});
