import 'dart:async';

import 'package:authentication_data_source/authentication_data_source.dart';
import 'package:authentication_repository/src/models/models.dart';

export 'package:authentication_repository/src/models/models.dart';

part 'authentication_repository_impl.dart';

/// {@template authentication_repository}
/// A repository for User Authentication.
/// {@endtemplate}
abstract class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    AuthenticationDataSource? authenticationDataSource,
  }) : _authenticationDataSource =
            authenticationDataSource ?? AuthenticationLocalDataSource();

  final AuthenticationDataSource _authenticationDataSource;

  final StreamController<User> _userAuth = StreamController<User>();

  final StreamController<bool> _onboarding = StreamController<bool>();

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user async* {
    yield currentUser;
    yield* _userAuth.stream.map((user) {
      _authenticationDataSource.setCurrentUser(user.toEntity);
      return user;
    });
  }

  /// Stream of [bool] which will emit the current onboarding state when
  /// the onboarding state changes.
  Stream<bool> get onboarding async* {
    yield isOnboarded;
    yield* _onboarding.stream;
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    final userEntity = _authenticationDataSource.getCurrentUser();
    return userEntity == null ? User.empty : User.fromEntity(userEntity);
  }

  /// Updates the user stream with the new [user].
  void updateUser(User user) => _userAuth.add(user);

  /// Updates the onboarding stream with the new [value].
  void updateOnboarding({bool value = false}) => _onboarding.add(value);

  /// Register with the provided [username] and [password].
  void onboard({required String username, required String password});

  /// Convenience getter to determine whether the current user is onboarded.
  bool get isOnboarded => _authenticationDataSource.isOnboarded;

  /// Signs in with the provided [username] and [password].
  Future<void> login({
    required String username,
    required String password,
  });

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  void logout();

  /// Convenience getter to determine whether the current user is authenticated.
  bool get isAuthenticated => currentUser.isNotEmpty;

  /// Disposes the AuthenticationRepository and its dependencies.
  Future<void> dispose() async {
    _authenticationDataSource.dispose();
    await _onboarding.close();
    await _userAuth.close();
  }
}
