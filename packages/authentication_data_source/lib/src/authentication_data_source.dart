import 'dart:convert';

import 'package:authentication_data_source/src/entities/entities.dart';
import 'package:cache_client/cache_client.dart';

export 'package:authentication_data_source/src/entities/entities.dart';

part 'authentication_local_data_source.dart';

/// {@template authentication_data_source}
/// A data source for Authentication.
/// {@endtemplate}
abstract class AuthenticationDataSource {
  /// {@macro authentication_data_source}
  const AuthenticationDataSource();

  /// Convenience getter to determine whether the current user is onboarded.
  bool get isOnboarded;

  /// Registers a user.
  void onboard({required String username, required String password});

  /// Logs in a user.
  UserEntity login({
    required String username,
    required String password,
  });

  /// Returns the current user.
  UserEntity? getCurrentUser();

  /// Updates the current user.
  void setCurrentUser(UserEntity user);

  /// Dispose the AuthenticationDataSource and its dependencies.
  void dispose();
}
