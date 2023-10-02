import 'dart:async';

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
  late final AuthenticationGuard authenticationGuard;

  @override
  List<AutoRoute> get routes {
    authenticationGuard = AuthenticationGuard(appCubit);
    return [
      AutoRoute(page: OnboardingRoute.page),
      AutoRoute(
        page: LoginRoute.page,
        guards: [OnboardingGuard(appCubit)],
      ),
      AutoRoute(
        initial: true,
        page: AlbumsRoute.page,
        guards: [authenticationGuard],
      ),
      AutoRoute(page: AlbumPhotosRoute.page),
    ];
  }

  @override
  Future<void> dispose() async {
    await authenticationGuard.dispose();
    super.dispose();
  }
}
