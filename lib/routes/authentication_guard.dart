import 'package:albums/app/cubit/app_cubit.dart';
import 'package:albums/routes/routes.dart';
import 'package:auto_route/auto_route.dart';

class AuthenticationGuard extends AutoRouteGuard {
  const AuthenticationGuard(this.appCubit);

  final AppCubit appCubit;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = appCubit.state.isAuthenticated;
    if (isAuthenticated) {
      resolver.next();
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
