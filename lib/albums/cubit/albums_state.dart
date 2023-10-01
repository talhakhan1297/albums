part of 'albums_cubit.dart';

class AlbumsState extends Equatable {
  const AlbumsState({
    this.getAlbumsApiState = const APIState<List<Album>>(),
    this.createAlbumApiState = const APIState<void>(),
    this.deleteAlbumApiState = const APIState<void>(),
  });

  final APIState<List<Album>> getAlbumsApiState;
  final APIState<void> createAlbumApiState;
  final APIState<void> deleteAlbumApiState;

  AlbumsState copyWith({
    APIState<List<Album>>? getAlbumsApiState,
    APIState<void>? createAlbumApiState,
    APIState<void>? deleteAlbumApiState,
  }) {
    return AlbumsState(
      getAlbumsApiState: getAlbumsApiState ?? this.getAlbumsApiState,
      createAlbumApiState: createAlbumApiState ?? this.createAlbumApiState,
      deleteAlbumApiState: deleteAlbumApiState ?? this.deleteAlbumApiState,
    );
  }

  List<Album> get albums => getAlbumsApiState.data ?? [];

  @override
  List<Object> get props => [
        getAlbumsApiState,
        createAlbumApiState,
        deleteAlbumApiState,
      ];
}
