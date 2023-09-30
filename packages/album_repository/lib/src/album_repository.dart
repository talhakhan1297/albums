import 'package:album_data_source/album_data_source.dart';
import 'package:album_repository/src/models/models.dart';

export 'package:album_repository/src/models/models.dart';

part 'album_repository_impl.dart';

/// {@template album_repository}
/// A repository for managing Albums.
/// {@endtemplate}
abstract class AlbumRepository {
  /// {@macro album_repository}
  const AlbumRepository();

  /// Fetches list of [Album].
  Future<List<Album>> getAlbums();

  /// Deletes an albums with provided [id].
  Future<void> deleteAlbum(int id);

  /// Creates an albums.
  Future<void> createAlbum();

  /// Fetches list of [AlbumPhoto] with the provided [id].
  Future<List<AlbumPhoto>> getAlbumPhotos(int id);
}
