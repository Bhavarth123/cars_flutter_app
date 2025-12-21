import 'package:flutter_test/flutter_test.dart';
import 'package:cars/main.dart'; // update if your project folder name is different

void main() {
  testWidgets('Home shows Our Services', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Expect exactly one widget with the text "Our Services"
    expect(find.text('Our Services'), findsOneWidget);
  });
}
