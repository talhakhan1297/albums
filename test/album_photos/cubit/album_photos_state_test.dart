// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:album_repository/album_repository.dart';
import 'package:albums/album_photos/album_photos.dart';
import 'package:albums/utils/helpers/api_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mockAlbumPhoto = AlbumPhoto(
    albumId: 1,
    id: 1,
    title: 'title',
    url: 'url',
    thumbnailUrl: 'thumbnailUrl',
  );

  final mockAlbumPhotos = [mockAlbumPhoto];

  group('AlbumPhotosState', () {
    AlbumPhotosState createSubject({
      APICallState state = APICallState.initial,
      List<AlbumPhoto>? data,
      String? error,
    }) {
      return AlbumPhotosState(
        getAlbumPhotosApiState:
            APIState(state: state, data: data, error: error),
      );
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test(
        'albumPhotos getter returns albumPhotos when '
        '[getAlbumPhotosApiState.data] is not null', () {
      expect(
        createSubject(
          data: mockAlbumPhotos,
        ).albumPhotos,
        equals(mockAlbumPhotos),
      );
    });

    test(
        'albumPhotos getter returns empty list when '
        '[getAlbumPhotosApiState.data] is null', () {
      expect(
        createSubject().albumPhotos,
        equals([]),
      );
    });

    test('props are correct', () {
      expect(
        createSubject(
          state: APICallState.loaded,
          data: mockAlbumPhotos,
          error: 'error',
        ).props,
        equals(<Object?>[
          APIState(
            state: APICallState.loaded,
            data: mockAlbumPhotos,
            error: 'error',
          ),
        ]),
      );
      expect(
        createSubject(
          state: APICallState.loaded,
          data: mockAlbumPhotos,
          error: 'error',
        ).getAlbumPhotosApiState.props,
        equals(<Object?>[
          mockAlbumPhotos,
          APICallState.loaded,
          'error',
        ]),
      );
    });

    group('copyWith', () {
      test('returns the same object if not arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(getAlbumPhotosApiState: null),
          equals(createSubject()),
        );
        expect(
          createSubject().getAlbumPhotosApiState.copyWith(
                data: null,
                state: null,
                error: null,
              ),
          equals(createSubject().getAlbumPhotosApiState),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            getAlbumPhotosApiState: APIState(
              state: APICallState.loaded,
              data: mockAlbumPhotos,
              error: 'error',
            ),
          ),
          equals(
            createSubject(
              state: APICallState.loaded,
              data: mockAlbumPhotos,
              error: 'error',
            ),
          ),
        );
        expect(
          createSubject().getAlbumPhotosApiState.copyWith(
                state: APICallState.loaded,
                data: mockAlbumPhotos,
                error: 'error',
              ),
          equals(
            createSubject(
              state: APICallState.loaded,
              data: mockAlbumPhotos,
              error: 'error',
            ).getAlbumPhotosApiState,
          ),
        );
      });
    });
  });
}
