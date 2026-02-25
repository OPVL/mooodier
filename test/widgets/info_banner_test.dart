import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('InfoBanner', () {
    testWidgets('displays title and message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBanner(
              title: 'Banner Title',
              message: 'This is a test message',
            ),
          ),
        ),
      );

      expect(find.text('Banner Title'), findsOneWidget);
      expect(find.text('This is a test message'), findsOneWidget);
    });

    testWidgets('uses default background color from theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          home: const Scaffold(
            body: InfoBanner(
              title: 'Test',
              message: 'Message',
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(InfoBanner),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, isNotNull);
    });

    testWidgets('uses custom background color when provided', (tester) async {
      const customColor = Colors.amber;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBanner(
              title: 'Test',
              message: 'Message',
              backgroundColor: customColor,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(InfoBanner),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, customColor);
    });

    testWidgets('uses custom border color when provided', (tester) async {
      const customBorderColor = Colors.red;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBanner(
              title: 'Test',
              message: 'Message',
              borderColor: customBorderColor,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(InfoBanner),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);
    });

    testWidgets('has correct border radius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBanner(
              title: 'Test',
              message: 'Message',
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(InfoBanner),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, Radii.medium);
    });

    testWidgets('has correct margin', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBanner(
              title: 'Test',
              message: 'Message',
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(InfoBanner),
              matching: find.byType(Container),
            )
            .first,
      );

      expect(container.margin, const EdgeInsets.all(Spacings.lg));
    });

    testWidgets('has correct padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBanner(
              title: 'Test',
              message: 'Message',
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(InfoBanner),
              matching: find.byType(Container),
            )
            .first,
      );

      expect(container.padding, const EdgeInsets.all(Spacings.lg));
    });

    testWidgets('displays icon when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBanner(
              title: 'Test',
              message: 'Message',
              icon: Icons.info,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('does not display icon when not provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBanner(
              title: 'Test',
              message: 'Message',
            ),
          ),
        ),
      );

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('icon has correct size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBanner(
              title: 'Test',
              message: 'Message',
              icon: Icons.warning,
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.warning));
      expect(icon.size, 20);
    });

    testWidgets('icon uses primary color from theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          home: const Scaffold(
            body: InfoBanner(
              title: 'Test',
              message: 'Message',
              icon: Icons.check,
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.check));
      expect(icon.color, isNotNull);
    });

    testWidgets('title has bold font weight', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBanner(
              title: 'Bold Title',
              message: 'Message',
            ),
          ),
        ),
      );

      final titleText = tester.widget<Text>(find.text('Bold Title'));
      expect(titleText.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('message uses bodyMedium style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 16),
            ),
          ),
          home: const Scaffold(
            body: InfoBanner(
              title: 'Title',
              message: 'Test Message',
            ),
          ),
        ),
      );

      expect(find.text('Test Message'), findsOneWidget);
    });

    testWidgets('icon appears before title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBanner(
              title: 'Title',
              message: 'Message',
              icon: Icons.star,
            ),
          ),
        ),
      );

      final row = tester.widget<Row>(find.descendant(
        of: find.byType(Column),
        matching: find.byType(Row),
      ));

      expect(row.children.first, isA<Icon>());
    });
  });
}
