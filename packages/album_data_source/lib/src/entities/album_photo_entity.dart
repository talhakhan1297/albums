import 'package:equatable/equatable.dart';

/// {@template album_photo_entity}
/// An Entity class for Album Photo.
/// {@endtemplate}
class AlbumPhotoEntity extends Equatable {
  /// {@macro album_photo_entity}
  const AlbumPhotoEntity({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  /// Parses [AlbumPhotoEntity] from [json].
  factory AlbumPhotoEntity.fromJson(Map<String, dynamic> json) {
    return AlbumPhotoEntity(
      albumId: json['albumId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
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
