import 'package:album_repository/album_repository.dart';
import 'package:albums/album_photos/cubit/album_photos_cubit.dart';
import 'package:albums/utils/constants/constants.dart';
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
      appBar: AppBar(title: const Text(Constants.albumPhotosTitle)),
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
            case APICallState.initial:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class _AlbumPhotosSuccess extends StatelessWidget {
  const _AlbumPhotosSuccess(this.albumPhotos);

  final List<AlbumPhoto> albumPhotos;

  static const _placeHolderIcon = Center(child: Icon(Icons.image));

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 1 / 1.5,
  );

  static const _borderRadius = BorderRadius.vertical(top: Radius.circular(8));

  static const _gridPadding =
      EdgeInsets.symmetric(horizontal: 24, vertical: 16);

  static const _titlePadding = EdgeInsets.all(8);

  Widget errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) =>
      _placeHolderIcon;

  Widget loadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;
    return _placeHolderIcon;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: _gridPadding,
      gridDelegate: _gridDelegate,
      itemCount: albumPhotos.length,
      itemBuilder: (context, index) {
        final albumPhoto = albumPhotos[index];
        return Card(
          child: Column(
            children: [
              Flexible(
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: _borderRadius,
                  child: Image.network(
                    albumPhoto.thumbnailUrl ?? '',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: errorBuilder,
                    loadingBuilder: loadingBuilder,
                  ),
                ),
              ),
              Padding(
                padding: _titlePadding,
                child: Text(
                  albumPhoto.title ?? Constants.untitled,
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
