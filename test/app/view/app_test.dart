import 'package:albums/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders App', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(App), findsOneWidget);
    });
  });
}
