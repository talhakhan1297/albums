import 'package:equatable/equatable.dart';

/// {@template album_dto}
/// A Data Transfer class for an Album.
/// {@endtemplate}
class AlbumDto extends Equatable {
  /// {@macro album_dto}
  const AlbumDto({required this.userId, required this.id, required this.title});

  /// User Id of the album.
  final int? userId;

  /// Id of the album.
  final int? id;

  /// Title of the album.
  final String? title;

  /// Parses from [AlbumDto] to JSON.
  Map<String, dynamic> get toJson => {
        'userId': userId,
        'id': id,
        'title': title,
      };

  @override
  List<Object?> get props => [userId, id, title];
}
