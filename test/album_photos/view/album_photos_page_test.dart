// ignore_for_file: prefer_const_constructors

import 'package:album_repository/album_repository.dart';
import 'package:albums/album_photos/album_photos.dart';
import 'package:albums/album_photos/view/album_photos_page.dart';
import 'package:albums/album_photos/widgets/widgets.dart';
import 'package:albums/utils/constants/constants.dart';
import 'package:albums/utils/helpers/api_state.dart';
import 'package:albums/utils/widgets/api_failure.dart';
import 'package:albums/utils/widgets/api_loading.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumPhotosCubit extends MockCubit<AlbumPhotosState>
    implements AlbumPhotosCubit {}

extension on WidgetTester {
  Future<void> pumpAlbumPhotosPage(AlbumPhotosCubit cubit) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: AlbumPhotosPage(id: 1),
        ),
      ),
    );
  }
}

void main() {
  late AlbumPhotosCubit photosCubit;

  setUp(() {
    photosCubit = MockAlbumPhotosCubit();
  });

  group('AlbumPhotosView', () {
    final mockAlbumPhotos = List.generate(
      5,
      (i) => AlbumPhoto(
        albumId: i,
        id: i,
        title: 'title',
        url: 'url',
        thumbnailUrl: 'thumbnailUrl',
      ),
    );

    testWidgets(
      'renders AppBar with title text',
      (tester) async {
        when(() => photosCubit.state).thenReturn(const AlbumPhotosState());
        await tester.pumpAlbumPhotosPage(photosCubit);

        expect(find.byType(AppBar), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(AppBar),
            matching: find.text(Constants.albumPhotosTitle),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
        'renders SizedBox '
        'when album photos status is initial', (tester) async {
      when(() => photosCubit.state).thenReturn(const AlbumPhotosState());
      await tester.pumpAlbumPhotosPage(photosCubit);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets(
        'renders LoadingWidget '
        'when album photos status is loading', (tester) async {
      when(() => photosCubit.state).thenReturn(
        AlbumPhotosState(
          getAlbumPhotosApiState:
              APIState<List<AlbumPhoto>>(state: APICallState.loading),
        ),
      );
      await tester.pumpAlbumPhotosPage(photosCubit);
      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets(
        'renders ${Constants.emptyPhotosMessage} '
        'when album photos status is success but with 0 photos',
        (tester) async {
      when(() => photosCubit.state).thenReturn(
        AlbumPhotosState(
          getAlbumPhotosApiState:
              APIState<List<AlbumPhoto>>(state: APICallState.loaded),
        ),
      );
      await tester.pumpAlbumPhotosPage(photosCubit);
      expect(find.text(Constants.emptyPhotosMessage), findsOneWidget);
    });

    testWidgets(
        'renders AlbumPhotos '
        'when album photos status is success with mockAlbumPhotos',
        (tester) async {
      when(() => photosCubit.state).thenReturn(
        AlbumPhotosState(
          getAlbumPhotosApiState: APIState<List<AlbumPhoto>>(
            state: APICallState.loaded,
            data: mockAlbumPhotos,
          ),
        ),
      );
      await tester.pumpAlbumPhotosPage(photosCubit);
      expect(find.byType(PhotoCard), findsWidgets);
    });

    testWidgets(
        'renders FailureWidget '
        'when album photos status is failure', (tester) async {
      when(() => photosCubit.state).thenReturn(
        AlbumPhotosState(
          getAlbumPhotosApiState:
              APIState<List<AlbumPhoto>>(state: APICallState.failure),
        ),
      );
      await tester.pumpAlbumPhotosPage(photosCubit);
      expect(find.byType(FailureWidget), findsOneWidget);
    });
  });
}
