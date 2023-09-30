import 'package:equatable/equatable.dart';

/// {@template album_entity}
/// An Entity class for Album.
/// {@endtemplate}
class AlbumEntity extends Equatable {
  /// {@macro album_entity}
  const AlbumEntity({
    this.userId,
    this.id,
    this.title,
  });

  /// Parses [AlbumEntity] from [json].
  factory AlbumEntity.fromJson(Map<String, dynamic> json) {
    return AlbumEntity(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
    );
  }

  /// User Id of the album.
  final int? userId;

  /// Id of the album.
  final int? id;

  /// Title of the album.
  final String? title;

  @override
  List<Object?> get props => [userId, id, title];
}
