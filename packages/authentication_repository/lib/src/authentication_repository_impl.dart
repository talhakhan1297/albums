part of 'authentication_repository.dart';

/// {@template authentication_repository_impl}
/// An implementation of AuthenticationRepository.
/// {@endtemplate}
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  @override
  void onboard({required String username, required String password}) {
    _authenticationDataSource.onboard(
      username: username,
      password: password,
    );

    updateOnboarding(value: true);
  }

  @override
  Future<void> login({
    required String username,
    required String password,
  }) async {
    final entity = _authenticationDataSource.login(
      username: username,
      password: password,
    );

    updateUser(User.fromEntity(entity));
  }

  @override
  void logout() => updateUser(User.empty);
}
