import 'dart:convert';

import 'package:album_data_source/src/entities/entities.dart';
import 'package:http/http.dart' as http;

export 'package:album_data_source/src/entities/entities.dart';

part 'album_remote_data_source.dart';

/// {@template album_data_source}
/// A data source for managing Albums.
/// {@endtemplate}
abstract class AlbumDataSource {
  /// {@macro album_data_source}
  const AlbumDataSource();

  /// Fetches list of [AlbumEntity].
  Future<List<AlbumEntity>> getAlbums();

  /// Deletes an albums with provided [id].
  Future<void> deleteAlbum(int id);

  /// Creates an albums.
  Future<void> createAlbum();

  /// Fetches list of [AlbumPhotoEntity] with the provided [id].
  Future<List<AlbumPhotoEntity>> getAlbumPhotos(int id);

  /// Dispose the AlbumDataSource and its dependencies.
  void dispose();
}
