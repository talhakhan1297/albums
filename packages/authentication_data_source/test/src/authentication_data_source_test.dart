// ignore_for_file: prefer_const_constructors
import 'package:authentication_data_source/authentication_data_source.dart';
import 'package:test/test.dart';

void main() {
  group('AuthenticationDataSource', () {
    test('can be instantiated', () {
      expect(AuthenticationLocalDataSource(), isNotNull);
    });
  });
}
