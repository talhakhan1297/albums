import 'package:albums/app/cubit/app_cubit.dart';
import 'package:albums/routes/routes.dart';
import 'package:auto_route/auto_route.dart';

class OnboardingGuard extends AutoRouteGuard {
  const OnboardingGuard(this.appCubit);

  final AppCubit appCubit;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isOnboarded = appCubit.state.isOnboarded;
    if (isOnboarded) {
      resolver.next();
    } else {
      resolver.redirect(const OnboardingRoute());
    }
  }
}
