import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saed_generator/main.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text('Saed Generator'))));

    // Verify that the title of the app appears.
    expect(find.text('Saed Generator'), findsWidgets);
  });
}
