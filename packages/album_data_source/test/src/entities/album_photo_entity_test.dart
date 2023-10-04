// ignore_for_file: prefer_const_constructors

import 'package:album_data_source/album_data_source.dart';
import 'package:test/test.dart';

void main() {
  group('AlbumPhotoEntity', () {
    test('supports value equality', () {
      expect(AlbumPhotoEntity(), AlbumPhotoEntity());
    });

    test('props are correct', () {
      expect(
        AlbumPhotoEntity(
          albumId: 1,
          id: 1,
          title: 'accusamus beatae ad facilis cum similique qui sunt',
          url: 'https://via.placeholder.com/600/92c952',
          thumbnailUrl: 'https://via.placeholder.com/150/92c952',
        ).props,
        equals(<Object?>[
          1,
          1,
          'accusamus beatae ad facilis cum similique qui sunt',
          'https://via.placeholder.com/600/92c952',
          'https://via.placeholder.com/150/92c952',
        ]),
      );
    });

    group('fromJson', () {
      test('returns correct AlbumPhotoEntity object', () {
        expect(
          AlbumPhotoEntity.fromJson(
            const <String, dynamic>{
              'albumId': 1,
              'id': 1,
              'title': 'accusamus beatae ad facilis cum similique qui sunt',
              'url': 'https://via.placeholder.com/600/92c952',
              'thumbnailUrl': 'https://via.placeholder.com/150/92c952',
            },
          ),
          isA<AlbumPhotoEntity>()
              .having((p) => p.albumId, 'albumId', 1)
              .having((p) => p.id, 'id', 1)
              .having(
                (p) => p.title,
                'title',
                'accusamus beatae ad facilis cum similique qui sunt',
              )
              .having(
                (p) => p.url,
                'url',
                'https://via.placeholder.com/600/92c952',
              )
              .having(
                (p) => p.thumbnailUrl,
                'thumbnailUrl',
                'https://via.placeholder.com/150/92c952',
              ),
        );
      });
    });
  });
}
