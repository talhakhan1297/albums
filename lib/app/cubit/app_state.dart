part of 'app_cubit.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState({
    this.authenticationStatus = AuthenticationStatus.unknown,
    this.user = User.empty,
    this.isOnboarded = false,
  });

  final AuthenticationStatus authenticationStatus;
  final User user;
  final bool isOnboarded;

  AppState copyWith({
    AuthenticationStatus? authenticationStatus,
    User? user,
    bool? isOnboarded,
  }) {
    return AppState(
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
      user: user ?? this.user,
      isOnboarded: isOnboarded ?? this.isOnboarded,
    );
  }

  bool get isNotOnboarded => !isOnboarded;

  bool get isAuthenticated =>
      authenticationStatus == AuthenticationStatus.authenticated;

  bool get isUnauthenticated => !isAuthenticated;

  @override
  List<Object?> get props => [authenticationStatus, user, isOnboarded];
}
