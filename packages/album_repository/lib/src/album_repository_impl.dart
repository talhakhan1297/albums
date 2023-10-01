part of 'album_repository.dart';

/// {@template album_repository_impl}
/// A repository for managing Albums.
/// {@endtemplate}
class AlbumRepositoryImpl implements AlbumRepository {
  /// {@macro album_repository_impl}
  AlbumRepositoryImpl({AlbumDataSource? albumDataSource})
      : _albumDataSource = albumDataSource ?? AlbumRemoteDataSource();

  final AlbumDataSource _albumDataSource;

  @override
  Future<List<Album>> getAlbums() async {
    final data = await _albumDataSource.getAlbums();
    return data.map(Album.fromEntity).toList();
  }

  @override
  Future<void> createAlbum() async {
    await _albumDataSource.createAlbum();
  }

  @override
  Future<void> deleteAlbum(int id) async {
    await _albumDataSource.deleteAlbum(id);
  }

  @override
  Future<List<AlbumPhoto>> getAlbumPhotos(int id) async {
    final data = await _albumDataSource.getAlbumPhotos(id);
    return data.map(AlbumPhoto.fromEntity).toList();
  }

  @override
  void dispose() {
    _albumDataSource.dispose();
  }
}
