// ignore_for_file: prefer_const_constructors
import 'package:album_data_source/album_data_source.dart';
import 'package:test/test.dart';

void main() {
  group('AlbumDataSource', () {
    test('can be instantiated', () {
      expect(AlbumRemoteDataSource(), isNotNull);
    });
  });
}
