import 'package:albums/app/app.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockUser extends Mock implements User {}

void main() {
  group('App', () {
    late AuthenticationRepository authenticationRepository;
    late User user;

    setUp(() {
      user = MockUser();
      authenticationRepository = MockAuthenticationRepository();
      GetIt.I.registerSingleton(authenticationRepository);

      when(() => authenticationRepository.onboarding)
          .thenAnswer((_) => const Stream.empty());

      when(() => authenticationRepository.user)
          .thenAnswer((_) => const Stream.empty());

      when(() => authenticationRepository.isOnboarded).thenReturn(true);
      when(() => authenticationRepository.isAuthenticated).thenReturn(true);
      when(() => authenticationRepository.currentUser).thenReturn(user);
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(App), findsOneWidget);
    });
  });
}
