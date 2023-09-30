import 'package:authentication_data_source/src/entities/entities.dart';
import 'package:cache_client/cache_client.dart';
import 'package:uuid/uuid.dart';

export 'package:authentication_data_source/src/entities/entities.dart';

part 'authentication_local_data_source.dart';

/// {@template authentication_data_source}
/// A data source for Authentication/
/// {@endtemplate}
abstract class AuthenticationDataSource {
  /// {@macro authentication_data_source}
  const AuthenticationDataSource();

  /// Registers a user.
  void onboard({required String username, required String password});

  /// Logs in a user.
  Future<UserEntity> login({
    required String username,
    required String password,
  });
}
