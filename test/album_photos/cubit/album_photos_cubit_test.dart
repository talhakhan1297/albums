// ignore_for_file: prefer_const_constructors

import 'package:album_repository/album_repository.dart';
import 'package:albums/album_photos/album_photos.dart';
import 'package:albums/utils/helpers/api_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumRepository extends Mock implements AlbumRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AlbumRepository albumRepository;

  const mockAlbumPhoto = AlbumPhoto(
    albumId: 1,
    id: 1,
    title: 'title',
    url: 'url',
    thumbnailUrl: 'thumbnailUrl',
  );

  final mockAlbumPhotos = [mockAlbumPhoto];

  setUp(() {
    albumRepository = MockAlbumRepository();
    when(() => albumRepository.getAlbumPhotos(any()))
        .thenAnswer((_) async => mockAlbumPhotos);
  });

  group('AlbumPhotosCubit', () {
    test('initial state is correct', () {
      final cubit = AlbumPhotosCubit(albumRepository: albumRepository);
      expect(cubit.state, AlbumPhotosState());
    });

    group('albumPhotosRequested', () {
      blocTest<AlbumPhotosCubit, AlbumPhotosState>(
        'verify albumRepository.getAlbumPhotos is called',
        build: () => AlbumPhotosCubit(albumRepository: albumRepository),
        act: (cubit) => cubit.albumPhotosRequested(1),
        verify: (_) =>
            verify(() => albumRepository.getAlbumPhotos(1)).called(1),
      );

      blocTest<AlbumPhotosCubit, AlbumPhotosState>(
        'emits [APICallState.loading, APICallState.loaded]',
        build: () => AlbumPhotosCubit(albumRepository: albumRepository),
        act: (cubit) => cubit.albumPhotosRequested(1),
        expect: () => <AlbumPhotosState>[
          const AlbumPhotosState(
            getAlbumPhotosApiState: APIState<List<AlbumPhoto>>(
              state: APICallState.loading,
            ),
          ),
          AlbumPhotosState(
            getAlbumPhotosApiState: APIState<List<AlbumPhoto>>(
              state: APICallState.loaded,
              data: mockAlbumPhotos,
            ),
          ),
        ],
      );

      blocTest<AlbumPhotosCubit, AlbumPhotosState>(
        'emits [APICallState.loading, APICallState.failure]',
        setUp: () {
          when(
            () => albumRepository.getAlbumPhotos(any()),
          ).thenThrow(
            Exception('Please check your internet and try again later.'),
          );
        },
        build: () => AlbumPhotosCubit(albumRepository: albumRepository),
        act: (cubit) => cubit.albumPhotosRequested(1),
        expect: () => const <AlbumPhotosState>[
          AlbumPhotosState(
            getAlbumPhotosApiState: APIState<List<AlbumPhoto>>(
              state: APICallState.loading,
            ),
          ),
          AlbumPhotosState(
            getAlbumPhotosApiState: APIState<List<AlbumPhoto>>(
              state: APICallState.failure,
              error:
                  'Exception: Please check your internet and try again later.',
            ),
          ),
        ],
      );
    });
  });
}
