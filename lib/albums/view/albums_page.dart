import 'package:album_repository/album_repository.dart';
import 'package:albums/albums/cubit/albums_cubit.dart';
import 'package:albums/app/cubit/app_cubit.dart';
import 'package:albums/routes/routes.dart';
import 'package:albums/utils/helpers/api_state.dart';
import 'package:albums/utils/helpers/snackbar.dart';
import 'package:albums/utils/widgets/api_failure.dart';
import 'package:albums/utils/widgets/api_loading.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
        actions: [
          IconButton(
            onPressed: context.read<AppCubit>().onLogoutRequested,
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      floatingActionButton: const AddAlbumButton(),
      body: BlocConsumer<AlbumsCubit, AlbumsState>(
        listenWhen: (previous, current) =>
            previous.deleteAlbumApiState != current.deleteAlbumApiState,
        listener: (context, state) {
          if (state.deleteAlbumApiState.isLoaded) {
            context.successSnackbar('Album deleted successfully.');
          } else if (state.deleteAlbumApiState.isFailure) {
            context.errorSnackbar(
              state.deleteAlbumApiState.error ?? 'Failed to delete the album.',
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.getAlbumsApiState != current.getAlbumsApiState ||
            previous.deleteAlbumApiState != current.deleteAlbumApiState,
        builder: (context, state) {
          switch (state.getAlbumsApiState.state) {
            case APICallState.loading:
              return const APILoading();
            case APICallState.loaded:
              return _AlbumsSuccess(state.albums);
            case APICallState.failure:
              return APIFailure(
                state.getAlbumsApiState.error,
                onTryAgain: context.read<AlbumsCubit>().albumsRequested,
              );
            case APICallState.initial:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class AddAlbumButton extends StatelessWidget {
  const AddAlbumButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumsCubit, AlbumsState>(
      listenWhen: (previous, current) =>
          previous.createAlbumApiState != current.createAlbumApiState,
      listener: (context, state) {
        if (state.createAlbumApiState.isLoaded) {
          context.successSnackbar('Album created successfully.');
        } else if (state.createAlbumApiState.isFailure) {
          context.errorSnackbar(
            state.createAlbumApiState.error ?? 'Failed to create the album.',
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.createAlbumApiState != current.createAlbumApiState,
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: context.read<AlbumsCubit>().createAlbumRequested,
          child: state.createAlbumApiState.isLoading
              ? const SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator.adaptive(),
                )
              : const Icon(Icons.add),
        );
      },
    );
  }
}

class _AlbumsSuccess extends StatelessWidget {
  const _AlbumsSuccess(this.albums);

  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 96),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return Dismissible(
          key: UniqueKey(),
          background: _dismissibleBackground(
            context,
            Alignment.centerLeft,
          ),
          secondaryBackground: _dismissibleBackground(
            context,
            Alignment.centerRight,
          ),
          onDismissed: (_) =>
              context.read<AlbumsCubit>().deleteAlbumRequested(index),
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
            title: Text(album.title ?? 'Untitled'),
            trailing: (album.id != null) ? Text('${album.id}') : null,
            onTap: () {
              if (album.id != null) {
                context.router.push(AlbumPhotosRoute(id: album.id!));
              }
            },
          ),
        );
      },
    );
  }

  Widget _dismissibleBackground(
    BuildContext context,
    AlignmentGeometry alignment,
  ) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.error;
    final iconColor = theme.colorScheme.onError;
    return Container(
      alignment: alignment,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.delete, color: iconColor),
      ),
    );
  }
}
