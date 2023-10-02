import 'dart:async';

import 'package:albums/app/cubit/app_cubit.dart';
import 'package:albums/routes/routes.dart';
import 'package:auto_route/auto_route.dart';

class AuthenticationGuard extends AutoRouteGuard {
  AuthenticationGuard(this.appCubit);

  final AppCubit appCubit;

  late StreamSubscription<AppState> _appStateSubscription;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = appCubit.state.isAuthenticated;
    if (isAuthenticated) {
      resolver.next();
    } else {
      resolver.redirect(const LoginRoute());
      _appStateSubscription = appCubit.stream.listen((state) async {
        if (state.isNotOnboarded) {
          await router.replaceAll([const OnboardingRoute()]);
        } else if (state.isUnauthenticated) {
          await router.replaceAll([const LoginRoute()]);
        } else {
          await router.replaceAll([const AlbumsRoute()]);
        }
      });
    }
  }

  Future<void> dispose() async {
    await _appStateSubscription.cancel();
  }
}
