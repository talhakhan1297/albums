import 'package:album_repository/album_repository.dart';
import 'package:albums/utils/helpers/api_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'albums_state.dart';

class AlbumsCubit extends Cubit<AlbumsState> {
  AlbumsCubit({required AlbumRepository albumRepository})
      : _albumRepository = albumRepository,
        super(const AlbumsState());

  final AlbumRepository _albumRepository;

  Future<void> albumsRequested() async {
    emit(
      state.copyWith(getAlbumsApiState: state.getAlbumsApiState.toLoading()),
    );

    try {
      final data = await _albumRepository.getAlbums();

      emit(
        state.copyWith(
          getAlbumsApiState: state.getAlbumsApiState.toLoaded(data: data),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          getAlbumsApiState: state.getAlbumsApiState.toFailure(
            error: e.toString(),
          ),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(getAlbumsApiState: state.getAlbumsApiState.toFailure()),
      );
    }
  }

  Future<void> createAlbumRequested() async {
    emit(
      state.copyWith(
        createAlbumApiState: state.createAlbumApiState.toLoading(),
      ),
    );

    final albums = state.albums.map((e) => e).toList();

    try {
      final newAlbum = await _albumRepository.createAlbum(
        const AlbumDto(id: 1, userId: 1, title: 'lorem ipsum'),
      );

      albums.insert(0, newAlbum);

      emit(
        state.copyWith(
          createAlbumApiState: state.createAlbumApiState.toLoaded(),
          getAlbumsApiState: state.getAlbumsApiState.copyWith(data: albums),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          createAlbumApiState: state.createAlbumApiState.toFailure(
            error: e.toString(),
          ),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          createAlbumApiState: state.createAlbumApiState.toFailure(),
        ),
      );
    }
  }

  Future<void> deleteAlbumRequested(int index) async {
    final albums = state.albums.map((e) => e).toList();
    final album = albums[index];
    final id = album.id;
    albums.removeAt(index);

    emit(
      state.copyWith(
        deleteAlbumApiState: state.deleteAlbumApiState.toLoading(),
        getAlbumsApiState: state.getAlbumsApiState.copyWith(data: albums),
      ),
    );

    try {
      if (id != null) {
        await _albumRepository.deleteAlbum(id);
      } else {
        throw Exception('Something went wrong!');
      }

      emit(
        state.copyWith(
          deleteAlbumApiState: state.deleteAlbumApiState.toLoaded(),
          getAlbumsApiState: state.getAlbumsApiState.copyWith(
            data: albums,
          ),
        ),
      );
    } on Exception catch (e) {
      albums.insert(index, album);
      emit(
        state.copyWith(
          deleteAlbumApiState: state.deleteAlbumApiState.toFailure(
            error: e.toString(),
          ),
          getAlbumsApiState: state.getAlbumsApiState.copyWith(data: albums),
        ),
      );
    } catch (_) {
      albums.insert(index, album);
      emit(
        state.copyWith(
          deleteAlbumApiState: state.deleteAlbumApiState.toFailure(),
          getAlbumsApiState: state.getAlbumsApiState.copyWith(data: albums),
        ),
      );
    }
  }
}
