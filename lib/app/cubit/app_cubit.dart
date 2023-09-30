import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          AppState(
            authenticationStatus: authenticationRepository.isAuthenticated
                ? AuthenticationStatus.authenticated
                : AuthenticationStatus.unauthenticated,
            user: authenticationRepository.currentUser,
            isOnboarded: authenticationRepository.isOnboarded,
          ),
        ) {
    _userSubscription = authenticationRepository.user.listen(_onUserChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    await _authenticationRepository.dispose();
    return super.close();
  }

  void _onUserChanged(User user) {
    emit(
      state.copyWith(
        authenticationStatus: user.isNotEmpty
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated,
        user: user,
      ),
    );
  }

  void onLogoutRequested() => _authenticationRepository.logout();
}
