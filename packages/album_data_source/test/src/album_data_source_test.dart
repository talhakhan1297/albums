// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:album_data_source/album_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  const baseUrl = 'jsonplaceholder.typicode.com';
  const albumsEndpoint = 'albums';
  const photosEndpoint = 'photos';
  const generalErrorMessage = 'Something went wrong!';
  const mockJsonResponse = [
    {
      'albumId': 1,
      'id': 1,
      'title': 'accusamus beatae ad facilis cum similique qui sunt',
      'url': 'https://via.placeholder.com/600/92c952',
      'thumbnailUrl': 'https://via.placeholder.com/150/92c952',
    }
  ];

  group('AlbumDataSource', () {
    late http.Client httpClient;
    late AlbumDataSource albumDataSource;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      albumDataSource = AlbumRemoteDataSource(httpClient: httpClient);
    });

    test('can be instantiated', () {
      expect(AlbumRemoteDataSource(), isNotNull);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(AlbumRemoteDataSource(), isNotNull);
      });
    });

    group('getAlbumPhotos', () {
      const id = 1;
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(jsonEncode(mockJsonResponse));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await albumDataSource.getAlbumPhotos(id);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(baseUrl, '$albumsEndpoint/$id/$photosEndpoint'),
          ),
        ).called(1);
      });

      test('throws Exception on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => albumDataSource.getAlbumPhotos(id),
          throwsA(isA<Exception>()),
        );
      });

      test('shows correct message on Exception', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await albumDataSource.getAlbumPhotos(id);
        } catch (e) {
          expect(e.toString(), 'Exception: $generalErrorMessage');
        }
      });
    });
  });
}
