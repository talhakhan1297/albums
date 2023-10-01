part of 'album_photos_cubit.dart';

class AlbumPhotosState extends Equatable {
  const AlbumPhotosState({
    this.getAlbumPhotosApiState = const APIState<List<AlbumPhoto>>(),
  });

  final APIState<List<AlbumPhoto>> getAlbumPhotosApiState;

  AlbumPhotosState copyWith({
    APIState<List<AlbumPhoto>>? getAlbumPhotosApiState,
  }) {
    return AlbumPhotosState(
      getAlbumPhotosApiState:
          getAlbumPhotosApiState ?? this.getAlbumPhotosApiState,
    );
  }

  List<AlbumPhoto> get albumPhotos => getAlbumPhotosApiState.data ?? [];

  @override
  List<Object> get props => [getAlbumPhotosApiState];
}
