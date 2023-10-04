import 'package:album_repository/album_repository.dart';
import 'package:albums/albums/cubit/albums_cubit.dart';
import 'package:albums/app/cubit/app_cubit.dart';
import 'package:albums/routes/routes.dart';
import 'package:albums/utils/constants/constants.dart';
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
        title: const Text(Constants.albumsTitle),
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
            context.successSnackbar(Constants.albumDeletedMessage);
          } else if (state.deleteAlbumApiState.isFailure) {
            context.errorSnackbar(
              state.deleteAlbumApiState.error ??
                  Constants.albumDeleteFailedMessage,
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.getAlbumsApiState != current.getAlbumsApiState ||
            previous.deleteAlbumApiState != current.deleteAlbumApiState,
        builder: (context, state) {
          switch (state.getAlbumsApiState.state) {
            case APICallState.loading:
              return const LoadingWidget();
            case APICallState.loaded:
              if (state.albums.isEmpty) {
                return FailureWidget(
                  Constants.emptyAlbumsMessage,
                  onTryAgain: () => getAlbums(context),
                );
              }
              return _AlbumsSuccess(state.albums);
            case APICallState.failure:
              return FailureWidget(
                state.getAlbumsApiState.error,
                onTryAgain: () => getAlbums(context),
              );
            case APICallState.initial:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Future<void> getAlbums(BuildContext context) =>
      context.read<AlbumsCubit>().albumsRequested();
}

class AddAlbumButton extends StatelessWidget {
  const AddAlbumButton({super.key});

  static const _loadingIndicator = SizedBox.square(
    dimension: 24,
    child: CircularProgressIndicator.adaptive(),
  );

  static const _addIcon = Icon(Icons.add);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumsCubit, AlbumsState>(
      listenWhen: (previous, current) =>
          previous.createAlbumApiState != current.createAlbumApiState,
      listener: (context, state) {
        if (state.createAlbumApiState.isLoaded) {
          context.successSnackbar(Constants.albumCreatedMessage);
        } else if (state.createAlbumApiState.isFailure) {
          context.errorSnackbar(
            state.createAlbumApiState.error ??
                Constants.albumCreateFailedMessage,
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.createAlbumApiState != current.createAlbumApiState,
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: context.read<AlbumsCubit>().createAlbumRequested,
          child: state.createAlbumApiState.isLoading
              ? _loadingIndicator
              : _addIcon,
        );
      },
    );
  }
}

class _AlbumsSuccess extends StatelessWidget {
  const _AlbumsSuccess(this.albums);

  final List<Album> albums;

  static const _tilePadding = EdgeInsets.fromLTRB(24, 0, 24, 12);
  static const _listPadding = EdgeInsets.only(bottom: 96);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: _listPadding,
      itemCount: albums.length,
      itemBuilder: itemBuilder,
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    final album = albums[index];

    final trailing = (album.id != null) ? Text('${album.id}') : null;
    final title = Text(album.title ?? Constants.untitled);

    void onTap() => album.id != null
        ? context.router.push(AlbumPhotosRoute(id: album.id!))
        : null;

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
        contentPadding: _tilePadding,
        title: title,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  Widget _dismissibleBackground(
    BuildContext context,
    AlignmentGeometry alignment,
  ) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.error;
    final iconColor = theme.colorScheme.onError;

    const iconPadding = EdgeInsets.symmetric(horizontal: 16);

    final deleteIcon = Icon(Icons.delete, color: iconColor);

    return Container(
      alignment: alignment,
      color: backgroundColor,
      child: Padding(padding: iconPadding, child: deleteIcon),
    );
  }
}
