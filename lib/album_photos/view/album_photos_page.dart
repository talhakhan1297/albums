import 'package:album_repository/album_repository.dart';
import 'package:albums/album_photos/cubit/album_photos_cubit.dart';
import 'package:albums/utils/helpers/api_state.dart';
import 'package:albums/utils/widgets/api_failure.dart';
import 'package:albums/utils/widgets/api_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumPhotosPage extends StatelessWidget {
  const AlbumPhotosPage({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Album Photos')),
      body: BlocBuilder<AlbumPhotosCubit, AlbumPhotosState>(
        buildWhen: (previous, current) =>
            previous.getAlbumPhotosApiState != current.getAlbumPhotosApiState,
        builder: (context, state) {
          switch (state.getAlbumPhotosApiState.state) {
            case APICallState.loading:
              return const APILoading();
            case APICallState.loaded:
              return _AlbumPhotosSuccess(state.albumPhotos);
            case APICallState.failure:
              return APIFailure(
                state.getAlbumPhotosApiState.error,
                onTryAgain: () =>
                    context.read<AlbumPhotosCubit>().albumPhotosRequested(id),
              );
          }
        },
      ),
    );
  }
}

class _AlbumPhotosSuccess extends StatelessWidget {
  const _AlbumPhotosSuccess(this.albumPhotos);

  final List<AlbumPhoto> albumPhotos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1 / 1.5,
      ),
      itemCount: albumPhotos.length,
      itemBuilder: (context, index) {
        final albumPhoto = albumPhotos[index];
        return Card(
          child: Column(
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    albumPhoto.thumbnailUrl ?? '',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.image)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  albumPhoto.title ?? 'Untitled',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
