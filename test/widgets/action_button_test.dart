import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('ActionButton', () {
    testWidgets('displays text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionButton(
              text: 'Click Me',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
    });

    group('primary variant', () {
      testWidgets('renders as OutlinedButton by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'Primary',
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(OutlinedButton), findsOneWidget);
        expect(find.byType(TextButton), findsNothing);
      });

      testWidgets('has pill-shaped border radius', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'Primary',
                onPressed: () {},
                variant: ActionButtonVariant.primary,
              ),
            ),
          ),
        );

        final button =
            tester.widget<OutlinedButton>(find.byType(OutlinedButton));
        final shape =
            button.style?.shape?.resolve({}) as RoundedRectangleBorder?;
        final borderRadius = shape?.borderRadius as BorderRadius?;

        expect(borderRadius?.topLeft.x, Radii.pill);
      });

      testWidgets('has minimum height of 56', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'Primary',
                onPressed: () {},
              ),
            ),
          ),
        );

        final button =
            tester.widget<OutlinedButton>(find.byType(OutlinedButton));
        final minSize = button.style?.minimumSize?.resolve({});

        expect(minSize?.height, 56);
        expect(minSize?.width, double.infinity);
      });

      testWidgets('displays icon when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'With Icon',
                icon: Icons.check,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.check), findsOneWidget);
      });

      testWidgets('icon has correct size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'With Icon',
                icon: Icons.check,
                onPressed: () {},
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byIcon(Icons.check));
        expect(icon.size, 18);
      });

      testWidgets('icon appears before text', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'With Icon',
                icon: Icons.check,
                onPressed: () {},
              ),
            ),
          ),
        );

        final row = tester.widget<Row>(find.descendant(
          of: find.byType(OutlinedButton),
          matching: find.byType(Row),
        ));

        expect(row.children.first, isA<Icon>());
      });
    });

    group('subtle variant', () {
      testWidgets('renders as TextButton', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'Subtle',
                variant: ActionButtonVariant.subtle,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(TextButton), findsOneWidget);
        expect(find.byType(OutlinedButton), findsNothing);
      });

      testWidgets('displays icon when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'Subtle',
                variant: ActionButtonVariant.subtle,
                icon: Icons.add,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.add), findsOneWidget);
      });
    });

    group('interactions', () {
      testWidgets('calls onPressed when tapped', (tester) async {
        var pressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'Tap Me',
                onPressed: () => pressed = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(OutlinedButton));
        expect(pressed, isTrue);
      });

      testWidgets('is disabled when onPressed is null', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'Disabled',
                onPressed: null,
              ),
            ),
          ),
        );

        final button =
            tester.widget<OutlinedButton>(find.byType(OutlinedButton));
        expect(button.onPressed, isNull);
      });

      testWidgets('subtle variant is disabled when onPressed is null',
          (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'Disabled',
                variant: ActionButtonVariant.subtle,
                onPressed: null,
              ),
            ),
          ),
        );

        final button = tester.widget<TextButton>(find.byType(TextButton));
        expect(button.onPressed, isNull);
      });
    });

    group('without icon', () {
      testWidgets('does not display spacing when no icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActionButton(
                text: 'No Icon',
                onPressed: () {},
              ),
            ),
          ),
        );

        final row = tester.widget<Row>(find.descendant(
          of: find.byType(OutlinedButton),
          matching: find.byType(Row),
        ));

        // Should only have text, no icon or spacing
        expect(row.children.length, 1);
      });
    });

    testWidgets('content has minimum size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionButton(
              text: 'Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      final row = tester.widget<Row>(find.descendant(
        of: find.byType(OutlinedButton),
        matching: find.byType(Row),
      ));

      expect(row.mainAxisSize, MainAxisSize.min);
    });
  });
}
