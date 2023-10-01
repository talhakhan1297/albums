import 'package:albums/album_photos/album_photos.dart';
import 'package:albums/albums/albums.dart';
import 'package:albums/app/app.dart';
import 'package:albums/login/login.dart';
import 'package:albums/onboarding/onboarding.dart';
import 'package:albums/routes/authentication_guard.dart';
import 'package:albums/routes/onboarding_guard.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  AppRouter(this.appCubit);

  final AppCubit appCubit;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: LoginRoute.page, guards: [OnboardingGuard(appCubit)]),
        AutoRoute(
          initial: true,
          page: AlbumsRoute.page,
          guards: [AuthenticationGuard(appCubit)],
        ),
        AutoRoute(page: AlbumPhotosRoute.page),
      ];
}
