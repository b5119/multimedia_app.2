import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:multimedia_learning_companion/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MultimediaLearningApp());

    // Verify that the app title appears
    expect(find.text('Multimedia Learning Companion'), findsOneWidget);
  });
}