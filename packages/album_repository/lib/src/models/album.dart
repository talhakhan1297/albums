import 'package:album_data_source/album_data_source.dart';
import 'package:equatable/equatable.dart';

/// {@template album_entity}
/// An Entity class for Album.
/// {@endtemplate}
class Album extends Equatable {
  /// {@macro album_entity}
  const Album({
    this.userId,
    this.id,
    this.title,
  });

  /// Parses [Album] from [AlbumEntity].
  factory Album.fromEntity(AlbumEntity entity) {
    return Album(
      userId: entity.userId,
      id: entity.id,
      title: entity.title,
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
