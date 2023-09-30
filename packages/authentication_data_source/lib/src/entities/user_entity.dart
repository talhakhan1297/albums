import 'package:equatable/equatable.dart';

/// {@template user_entity}
/// Entity class for a user.
/// {@endtemplate}
class UserEntity extends Equatable {
  /// {@macro user_entity}
  const UserEntity({this.username});

  /// Parses from JSON to [UserEntity].
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(username: json['username'] as String?);
  }

  /// Username of the current user.
  final String? username;

  /// Parses from [UserEntity] to JSON.
  Map<String, dynamic> get toJson => {'username': username};

  @override
  List<Object?> get props => [username];
}
