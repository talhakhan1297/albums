part of 'authentication_data_source.dart';

/// {@template authentication_local_data_source}
/// Local data source for Authentication.
/// {@endtemplate}
class AuthenticationLocalDataSource implements AuthenticationDataSource {
  /// {@macro authentication_local_data_source}
  AuthenticationLocalDataSource({CacheClient? cacheClient})
      : _cacheClient = cacheClient ?? HiveCacheClient();

  final CacheClient _cacheClient;

  /// Users cache key.
  static const usersCacheKey = '__onboarded_users_cache_key__';

  /// Registers a user by storing it in local storage.
  @override
  void onboard({required String username, required String password}) {
    if (username.isEmpty || password.isEmpty) {
      throw Exception('Invalid username or password');
    }

    final usersList = _cacheClient.read<List<Map<String, dynamic>>>(
          key: usersCacheKey,
        ) ??
        [];

    final users = usersList.map(UserEntity.fromJson).toList();

    if (users.any((user) => user.username == username)) {
      throw Exception('User already exists.');
    }

    usersList.add({
      'id': const Uuid().v7(),
      'username': username,
      'password': password,
    });

    _cacheClient.write(key: usersCacheKey, value: usersList);
  }

  /// Logs in a user by checking if user exists in the local storage.
  @override
  Future<UserEntity> login({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      throw Exception('Invalid username or password');
    }

    final usersList = _cacheClient.read<List<Map<String, dynamic>>>(
          key: usersCacheKey,
        ) ??
        [];

    final users = usersList.map(UserEntity.fromJson).toList();

    final filteredUsers = users
        .where((user) => user.username == username && user.password == password)
        .toList();

    if (filteredUsers.isEmpty) {
      throw Exception('Invalid username or password');
    }

    return filteredUsers.first;
  }
}
