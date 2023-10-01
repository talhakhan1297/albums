// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AlbumPhotosRoute.name: (routeData) {
      final args = routeData.argsAs<AlbumPhotosRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AlbumPhotosView(
          id: args.id,
          key: args.key,
        ),
      );
    },
    AlbumsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AlbumsView(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginView(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingView(),
      );
    },
  };
}

/// generated route for
/// [AlbumPhotosView]
class AlbumPhotosRoute extends PageRouteInfo<AlbumPhotosRouteArgs> {
  AlbumPhotosRoute({
    required int id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AlbumPhotosRoute.name,
          args: AlbumPhotosRouteArgs(
            id: id,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AlbumPhotosRoute';

  static const PageInfo<AlbumPhotosRouteArgs> page =
      PageInfo<AlbumPhotosRouteArgs>(name);
}

class AlbumPhotosRouteArgs {
  const AlbumPhotosRouteArgs({
    required this.id,
    this.key,
  });

  final int id;

  final Key? key;

  @override
  String toString() {
    return 'AlbumPhotosRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [AlbumsView]
class AlbumsRoute extends PageRouteInfo<void> {
  const AlbumsRoute({List<PageRouteInfo>? children})
      : super(
          AlbumsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AlbumsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingView]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
