import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:web_demo/core/di/service_locator.dart';
import 'package:web_demo/main.dart';

void main() {
  testWidgets('App boots', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await configureDependencies();
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Public Home'), findsOneWidget);
    expect(find.byType(Scaffold), findsWidgets);
  });
}
