// ignore_for_file: prefer_const_constructors
import 'package:album_repository/album_repository.dart';
import 'package:test/test.dart';

void main() {
  group('AlbumRepository', () {
    test('can be instantiated', () {
      expect(AlbumRepositoryImpl(), isNotNull);
    });
  });
}
