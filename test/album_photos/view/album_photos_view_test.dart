// ignore_for_file: prefer_const_constructors

import 'package:album_repository/album_repository.dart';
import 'package:albums/album_photos/album_photos.dart';
import 'package:albums/album_photos/view/album_photos_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumsRepository extends Mock implements AlbumRepository {}

void main() {
  late AlbumRepository albumRepository;

  setUp(() {
    albumRepository = MockAlbumsRepository();
    GetIt.I.registerSingleton(albumRepository);
  });

  tearDown(() {
    GetIt.I.unregister(instance: albumRepository);
  });

  group('AlbumPhotosView', () {
    testWidgets('renders AlbumPhotosPage', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AlbumPhotosView(id: 1)));
      await tester.pumpAndSettle();
      expect(find.byType(AlbumPhotosPage), findsOneWidget);
    });
  });

  group('AlbumPhotosView', () {
    testWidgets(
      'calls getAlbumPhotos on initialization',
      (tester) async {
        await tester.pumpWidget(MaterialApp(home: AlbumPhotosView(id: 1)));
        await tester.pumpAndSettle();
        verify(() => albumRepository.getAlbumPhotos(any())).called(1);
      },
    );
  });
}
