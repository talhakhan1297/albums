import 'package:authentication_data_source/authentication_data_source.dart';
import 'package:equatable/equatable.dart';

/// {@template user_entity}
/// Model class for a user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user_entity}
  const User({this.username});

  /// Parses from [UserEntity] to [User].
  factory User.fromEntity(UserEntity entity) {
    return User(username: entity.username);
  }

  /// Username of the current user.
  final String? username;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(username: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  /// Parses from [User] to [UserEntity].
  UserEntity get toEntity => UserEntity(username: username);

  @override
  List<Object?> get props => [username];
}
