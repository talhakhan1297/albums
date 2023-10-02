import 'package:albums/app/cubit/app_cubit.dart';
import 'package:albums/routes/routes.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Albums'),
            TextButton(
              onPressed: () {
                context.router.push(AlbumPhotosRoute(id: 1));
              },
              child: const Text('Go to Album Photos'),
            ),
            TextButton(
              onPressed: () {
                context.read<AppCubit>().onLogoutRequested();
              },
              child: const Text('logout'),
            ),
            TextButton(
              onPressed: () {
                context.router.pop();
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
