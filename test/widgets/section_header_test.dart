import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('SectionHeader', () {
    testWidgets('displays title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(title: 'Test Section'),
          ),
        ),
      );

      expect(find.text('Test Section'), findsOneWidget);
    });

    testWidgets('applies correct text style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            textTheme: const TextTheme(
              titleMedium: TextStyle(fontSize: 20),
            ),
          ),
          home: const Scaffold(
            body: SectionHeader(title: 'Test'),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Test'));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('uses default padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(title: 'Test'),
          ),
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(
        padding.padding,
        const EdgeInsets.symmetric(
          horizontal: Spacings.lg,
          vertical: Spacings.sm,
        ),
      );
    });

    testWidgets('applies custom padding', (tester) async {
      const customPadding = EdgeInsets.all(20);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'Test',
              padding: customPadding,
            ),
          ),
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, customPadding);
    });

    testWidgets('displays trailing widget when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'Test',
              trailing: Icon(Icons.add),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('does not display trailing when not provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(title: 'Test'),
          ),
        ),
      );

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('title and trailing are in a row', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'Test',
              trailing: Icon(Icons.add),
            ),
          ),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.children.length, 2); // Text and Icon
    });

    testWidgets('title expands to fill available space', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'Test',
              trailing: Icon(Icons.add),
            ),
          ),
        ),
      );

      expect(find.byType(Expanded), findsOneWidget);
    });
  });
}
