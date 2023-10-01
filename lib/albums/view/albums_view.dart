import 'package:album_repository/album_repository.dart';
import 'package:albums/albums/cubit/albums_cubit.dart';
import 'package:albums/albums/view/albums_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class AlbumsView extends StatelessWidget {
  const AlbumsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumsCubit(
        albumRepository: GetIt.I<AlbumRepository>(),
      ),
      child: const AlbumsPage(),
    );
  }
}
