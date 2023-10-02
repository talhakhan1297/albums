import 'package:album_repository/album_repository.dart';
import 'package:albums/albums/cubit/albums_cubit.dart';
import 'package:albums/app/cubit/app_cubit.dart';
import 'package:albums/routes/routes.dart';
import 'package:albums/utils/helpers/api_state.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<AlbumsCubit>().createAlbumRequested,
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<AlbumsCubit, AlbumsState>(
        buildWhen: (previous, current) =>
            previous.getAlbumsApiState != current.getAlbumsApiState,
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
          }
        },
      ),
    );
  }
}

class _AlbumsSuccess extends StatelessWidget {
  const _AlbumsSuccess(this.albums);

  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 96),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              if (album.id != null) {
                context.router.push(AlbumPhotosRoute(id: album.id!));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(child: Text(album.title ?? 'Untitled')),
                  const SizedBox(width: 24),
                  if (album.id != null) Text('${album.id}'),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
    );
  }
}
