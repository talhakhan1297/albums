import 'package:albums/album_photos/album_photos.dart';
import 'package:albums/albums/albums.dart';
import 'package:albums/login/login.dart';
import 'package:albums/onboarding/onboarding.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(
          page: AlbumsRoute.page,
          children: [AutoRoute(page: AlbumPhotosRoute.page)],
        ),
      ];
}
