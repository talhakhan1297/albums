import 'package:album_repository/album_repository.dart';
import 'package:albums/utils/helpers/api_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'album_photos_state.dart';

class AlbumPhotosCubit extends Cubit<AlbumPhotosState> {
  AlbumPhotosCubit({required AlbumRepository albumRepository})
      : _albumRepository = albumRepository,
        super(const AlbumPhotosState());

  final AlbumRepository _albumRepository;

  Future<void> albumPhotosRequested(int id) async {
    emit(
      state.copyWith(
        getAlbumPhotosApiState: state.getAlbumPhotosApiState.toLoading(),
      ),
    );

    try {
      final data = await _albumRepository.getAlbumPhotos(id);

      emit(
        state.copyWith(
          getAlbumPhotosApiState:
              state.getAlbumPhotosApiState.toLoaded(data: data),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          getAlbumPhotosApiState: state.getAlbumPhotosApiState.toFailure(
            error: e.toString(),
          ),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          getAlbumPhotosApiState: state.getAlbumPhotosApiState.toFailure(),
        ),
      );
    }
  }
}
