part of 'authentication_data_source.dart';

/// {@template authentication_local_data_source}
/// Local data source for Authentication.
/// {@endtemplate}
class AuthenticationLocalDataSource implements AuthenticationDataSource {
  /// {@macro authentication_local_data_source}
  AuthenticationLocalDataSource({CacheClient? cacheClient})
      : _cacheClient = cacheClient ?? HiveCacheClient();

  final CacheClient _cacheClient;

  /// Onboarded users cache key.
  final _onboardedUsersCacheKey = '__onboarded_users_cache_key__';

  /// Current user cache key.
  final _currentUserCacheKey = '__current_user_cache_key__';

  @override
  bool get isOnboarded => _getOnboardedUsers().isNotEmpty;

  /// Registers a user by storing it in local storage.
  @override
  void onboard({required String username, required String password}) {
    if (username.isEmpty || password.isEmpty) {
      throw Exception('Invalid username or password');
    }

    final usersList = _getOnboardedUsers();

    final users = usersList.map(UserEntity.fromJson).toList();

    if (users.any((user) => user.username == username)) {
      throw Exception('User already exists.');
    }

    usersList.add({'username': username, 'password': password});

    _cacheClient.write(key: _onboardedUsersCacheKey, value: usersList);
  }

  /// Logs in a user by checking if user exists in the local storage.
  @override
  UserEntity login({
    required String username,
    required String password,
  }) {
    if (username.isEmpty || password.isEmpty) {
      throw Exception('Invalid username or password');
    }

    final usersList = _cacheClient.read<List<Map<String, dynamic>>>(
          key: _onboardedUsersCacheKey,
        ) ??
        [];

    final filteredUsers = usersList
        .where(
          (user) =>
              user['username'] == username && user['password'] == password,
        )
        .toList();

    if (filteredUsers.isEmpty) {
      throw Exception('Invalid username or password');
    }

    return UserEntity.fromJson(filteredUsers.first);
  }

  @override
  UserEntity? getCurrentUser() {
    final user = _cacheClient.read<Map<String, dynamic>>(
      key: _currentUserCacheKey,
    );

    return user == null ? null : UserEntity.fromJson(user);
  }

  @override
  void setCurrentUser(UserEntity user) {
    _cacheClient.write(key: _currentUserCacheKey, value: user.toJson);
  }

  @override
  void dispose() {
    _cacheClient.close();
  }

  List<Map<String, dynamic>> _getOnboardedUsers() {
    return _cacheClient.read<List<Map<String, dynamic>>>(
          key: _onboardedUsersCacheKey,
        ) ??
        [];
  }
}
