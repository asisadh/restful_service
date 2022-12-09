import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restful_service/main.dart' as app;
import 'package:restful_service/providers.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

void main() {
  test('main', () {
    expect(() => app.main(), throwsAssertionError);
  });

  test('Load providers', () {
    loadProviders();
    final fb = restExternalInterface.getExternalInterface(providersContext);
    expect(fb, isA<RestExternalInterface>());
  });

  testWidgets('Main app ::', (tester) async {
    await tester.pumpWidget(
      app.RestfulServiceApp(
        key: UniqueKey(),
      ),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Uncomment this to see the widget tree on the console
    // debugDumpApp();

    expect(find.byType(app.RestfulServiceApp), findsOneWidget);
  });
}
