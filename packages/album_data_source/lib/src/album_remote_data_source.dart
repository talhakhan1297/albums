part of 'album_data_source.dart';

/// {@template album_remote_data_source}
/// A remote data source for managing Albums.
/// {@endtemplate}
class AlbumRemoteDataSource implements AlbumDataSource {
  /// {@macro album_remote_data_source}
  AlbumRemoteDataSource({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'jsonplaceholder.typicode.com';
  static const _albumsEndpoint = 'albums';
  static const _photosEndpoint = 'photos';

  final http.Client _httpClient;

  @override
  Future<List<AlbumEntity>> getAlbums() async {
    final request = Uri.https(_baseUrl, _albumsEndpoint);

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw Exception('Something went wrong!');
    }

    final bodyJson = jsonDecode(response.body) as List;

    return bodyJson
        .map((e) => AlbumEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> createAlbum() async {
    final request = Uri.https(_baseUrl, _albumsEndpoint);

    final response = await _httpClient.post(
      request,
      body: {'userId': 1, 'id': 1, 'title': 'lorem ipsum'},
    );

    if (response.statusCode != 200) {
      throw Exception('Something went wrong!');
    }
  }

  @override
  Future<void> deleteAlbum(int id) async {
    final request = Uri.https(_baseUrl, '$_albumsEndpoint/$id');

    final response = await _httpClient.delete(request);

    if (response.statusCode != 200) {
      throw Exception('Something went wrong!');
    }
  }

  @override
  Future<List<AlbumPhotoEntity>> getAlbumPhotos(int id) async {
    final request = Uri.https(
      _baseUrl,
      '$_albumsEndpoint/$id/$_photosEndpoint',
    );

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw Exception('Something went wrong!');
    }

    final bodyJson = jsonDecode(response.body) as List;

    return bodyJson
        .map((e) => AlbumPhotoEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
