// ignore_for_file: prefer_const_constructors
import 'package:album_data_source/album_data_source.dart';
import 'package:album_repository/album_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAlbumDataSource extends Mock implements AlbumDataSource {}

class MockAlbumPhotoEntity extends Mock implements AlbumPhotoEntity {}

void main() {
  const mockResponse = [
    AlbumPhotoEntity(
      albumId: 1,
      id: 1,
      title: 'accusamus beatae ad facilis cum similique qui sunt',
      url: 'https://via.placeholder.com/600/92c952',
      thumbnailUrl: 'https://via.placeholder.com/150/92c952',
    ),
  ];

  group('AlbumRepository', () {
    late AlbumDataSource albumDataSource;
    late AlbumRepository albumRepository;

    setUp(() {
      albumDataSource = MockAlbumDataSource();
      albumRepository = AlbumRepositoryImpl(albumDataSource: albumDataSource);
    });

    test('can be instantiated', () {
      expect(AlbumRepositoryImpl(), isNotNull);
    });

    group('constructor', () {
      test('does not require an AlbumDataSource', () {
        expect(AlbumRepositoryImpl(), isNotNull);
      });
    });

    group('getAlbumPhotos', () {
      const id = 1;
      test('makes correct call', () async {
        when(() => albumDataSource.getAlbumPhotos(any()))
            .thenAnswer((_) async => mockResponse);

        try {
          await albumRepository.getAlbumPhotos(id);
        } catch (_) {}

        verify(() => albumDataSource.getAlbumPhotos(id)).called(1);
      });

      test('throws when getAlbumPhotos fails', () async {
        final exception = Exception('oops');
        when(() => albumDataSource.getAlbumPhotos(any())).thenThrow(exception);
        expect(
          () async => albumRepository.getAlbumPhotos(id),
          throwsA(exception),
        );
      });
    });
  });
}
