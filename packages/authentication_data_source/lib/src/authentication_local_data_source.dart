part of 'authentication_data_source.dart';

/// {@template authentication_local_data_source}
/// Local data source for Authentication.
/// {@endtemplate}
class AuthenticationLocalDataSource implements AuthenticationDataSource {
  /// {@macro authentication_local_data_source}
  AuthenticationLocalDataSource({CacheClient? cacheClient})
      : _cacheClient = cacheClient ?? HiveCacheClient();

  final CacheClient _cacheClient;

  static const _onboardedUsersCacheKey = '__onboarded_users_cache_key__';
  static const _currentUserCacheKey = '__current_user_cache_key__';

  static const _invalidInfoMessage = 'Invalid username or password';
  static const _userAlreadyExistMessage = 'User already exists.';

  @override
  bool get isOnboarded => _getOnboardedUsers().isNotEmpty;

  /// Registers a user by storing it in local storage.
  @override
  void onboard({required String username, required String password}) {
    if (username.isEmpty || password.isEmpty) {
      throw Exception(_invalidInfoMessage);
    }

    final usersList = _getOnboardedUsers();

    final users = usersList
        .map((e) => UserEntity.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();

    if (users.any((user) => user.username == username)) {
      throw Exception(_userAlreadyExistMessage);
    }

    usersList.add(jsonEncode({'username': username, 'password': password}));

    _cacheClient.write<List<String>>(
      key: _onboardedUsersCacheKey,
      value: usersList,
    );
  }

  /// Logs in a user by checking if user exists in the local storage.
  @override
  UserEntity login({
    required String username,
    required String password,
  }) {
    if (username.isEmpty || password.isEmpty) {
      throw Exception(_invalidInfoMessage);
    }

    final usersList = _getOnboardedUsers();

    final filteredUsers = usersList.where(
      (map) {
        final user = jsonDecode(map) as Map<dynamic, dynamic>;
        return user['username'] == username && user['password'] == password;
      },
    ).toList();

    if (filteredUsers.isEmpty) {
      throw Exception(_invalidInfoMessage);
    }

    return UserEntity.fromJson(
      jsonDecode(filteredUsers.first) as Map<String, dynamic>,
    );
  }

  @override
  UserEntity? getCurrentUser() {
    final user = _cacheClient.read<String>(
      key: _currentUserCacheKey,
    );

    return user == null
        ? null
        : UserEntity.fromJson(jsonDecode(user) as Map<String, dynamic>);
  }

  @override
  void setCurrentUser(UserEntity user) {
    _cacheClient.write<String>(
      key: _currentUserCacheKey,
      value: jsonEncode(user.toJson),
    );
  }

  @override
  void dispose() {
    _cacheClient.close();
  }

  List<String> _getOnboardedUsers() {
    return _cacheClient.read<List<String>>(
          key: _onboardedUsersCacheKey,
        ) ??
        [];
  }
}
