import 'package:equatable/equatable.dart';

/// {@template user_entity}
/// Entity  class for a user.
/// {@endtemplate}
class UserEntity extends Equatable {
  /// {@macro user_entity}
  const UserEntity({this.username, this.password});

  /// Parses from JSON to [UserEntity].
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      username: json['username'] as String?,
      password: json['password'] as String?,
    );
  }

  /// Stores the username of a user.
  final String? username;

  /// Stores the password of a user.
  final String? password;

  @override
  List<Object?> get props => [username, password];
}
