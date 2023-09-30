import 'package:album_data_source/album_data_source.dart';
import 'package:equatable/equatable.dart';

/// {@template album_photo_entity}
/// An Entity class for Album Photo.
/// {@endtemplate}
class AlbumPhoto extends Equatable {
  /// {@macro album_photo_entity}
  const AlbumPhoto({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  /// Parses [AlbumPhoto] from [AlbumPhotoEntity].
  factory AlbumPhoto.fromEntity(AlbumPhotoEntity entity) {
    return AlbumPhoto(
      albumId: entity.albumId,
      id: entity.id,
      title: entity.title,
      url: entity.url,
      thumbnailUrl: entity.thumbnailUrl,
    );
  }

  /// Id of the album.
  final int? albumId;

  /// Id of the photo.
  final int? id;

  /// Title of the album.
  final String? title;

  /// URL of the photo.
  final String? url;

  /// URL of the thumbnail.
  final String? thumbnailUrl;

  @override
  List<Object?> get props => [albumId, id, title, url, thumbnailUrl];
}
