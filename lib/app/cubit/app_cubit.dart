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
    _onboardingSubscription =
        authenticationRepository.onboarding.listen(_onOnboardingChanged);
    _userSubscription = authenticationRepository.user.listen(_onUserChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;
  late final StreamSubscription<bool> _onboardingSubscription;

  @override
  Future<void> close() async {
    await _onboardingSubscription.cancel();
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

  void _onOnboardingChanged(bool value) =>
      emit(state.copyWith(isOnboarded: value));

  void onLogoutRequested() => _authenticationRepository.logout();
}
