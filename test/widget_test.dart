import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:umee_hackathon/main.dart';
import 'package:umee_hackathon/services/local_storage_service.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create an instance of LocalStorageService
    final localStorageService = LocalStorageService();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(localStorageService: localStorageService));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
