// This is an example Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
//
// Visit https://flutter.dev/docs/cookbook/testing/widget/introduction for
// more information about Widget testing.

import 'package:example/src/app.dart';
import 'package:example/src/settings/settings_controller.dart';
import 'package:example/src/settings/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyWidget', () {
    testWidgets('should display a string of text', (WidgetTester tester) async {
      final SettingsController settingsController =
          SettingsController(SettingsService());

      // Load the user's preferred theme while the splash screen is displayed.
      // This prevents a sudden theme change when the app is first displayed.
      await settingsController.loadSettings();

      // Run the app and pass in the SettingsController. The app listens to the
      // SettingsController for changes, then passes it further down to the
      // SettingsView.

      // Define a Widget
      Widget myWidget = MyApp(settingsController: settingsController);

      // Build myWidget and trigger a frame.
      await tester.pumpWidget(myWidget);

      // Verify myWidget shows some text
      expect(find.byType(AnimatedBuilder), findsOneWidget);
    });
  });
}
