import 'package:album_repository/album_repository.dart';
import 'package:albums/album_photos/cubit/album_photos_cubit.dart';
import 'package:albums/album_photos/widgets/widgets.dart';
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
              return const LoadingWidget();
            case APICallState.loaded:
              if (state.albumPhotos.isEmpty) {
                return FailureWidget(
                  Constants.emptyPhotosMessage,
                  onTryAgain: () => getAlbumPhotos(context),
                );
              }
              return _AlbumPhotosSuccess(state.albumPhotos);
            case APICallState.failure:
              return FailureWidget(
                state.getAlbumPhotosApiState.error,
                onTryAgain: () => getAlbumPhotos(context),
              );
            case APICallState.initial:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Future<void> getAlbumPhotos(BuildContext context) =>
      context.read<AlbumPhotosCubit>().albumPhotosRequested(id);
}

class _AlbumPhotosSuccess extends StatelessWidget {
  const _AlbumPhotosSuccess(this.albumPhotos);

  final List<AlbumPhoto> albumPhotos;

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 1 / 1.5,
  );

  static const _gridPadding =
      EdgeInsets.symmetric(horizontal: 24, vertical: 16);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: _gridPadding,
      gridDelegate: _gridDelegate,
      itemCount: albumPhotos.length,
      itemBuilder: (context, index) => PhotoCard(albumPhotos[index]),
    );
  }
}
