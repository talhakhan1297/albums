import 'package:equatable/equatable.dart';

/// {@template user_entity}
/// Entity  class for a user.
/// {@endtemplate}
class UserEntity extends Equatable {
  /// {@macro user_entity}
  const UserEntity({this.id, this.username, this.password});

  /// Parses from JSON to [UserEntity].
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
    );
  }

  /// Unique identifier of a user.
  final String? id;

  /// Stores the username of a user.
  final String? username;

  /// Stores the password of a user.
  final String? password;

  @override
  List<Object?> get props => [username, password];
}
