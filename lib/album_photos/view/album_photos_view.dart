import 'package:album_repository/album_repository.dart';
import 'package:albums/album_photos/cubit/album_photos_cubit.dart';
import 'package:albums/album_photos/view/album_photos_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AlbumPhotosView extends StatelessWidget {
  const AlbumPhotosView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumPhotosCubit(
        albumRepository: GetIt.I<AlbumRepository>(),
      ),
      child: const AlbumPhotosPage(),
    );
  }
}
