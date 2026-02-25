import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('FrostedGlassContainer', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              child: Text('Child Widget'),
            ),
          ),
        ),
      );

      expect(find.text('Child Widget'), findsOneWidget);
    });

    testWidgets('applies blur effect', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              blur: 15,
              child: Text('Blurred'),
            ),
          ),
        ),
      );

      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('uses default blur value of 10', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              child: Text('Child'),
            ),
          ),
        ),
      );

      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('uses default opacity of 0.2', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              child: Text('Child'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(BackdropFilter),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, isNotNull);
    });

    testWidgets('applies custom opacity', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              opacity: 0.5,
              child: Text('Child'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(BackdropFilter),
          matching: find.byType(Container),
        ),
      );

      expect(container.decoration, isNotNull);
    });

    testWidgets('applies custom color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              color: Colors.blue,
              child: Text('Child'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(BackdropFilter),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, isNotNull);
    });

    testWidgets('applies border radius', (tester) async {
      const radius = BorderRadius.all(Radius.circular(20));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              borderRadius: radius,
              child: Text('Child'),
            ),
          ),
        ),
      );

      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(clipRRect.borderRadius, radius);

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(BackdropFilter),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, radius);
    });

    testWidgets('uses BorderRadius.zero by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              child: Text('Child'),
            ),
          ),
        ),
      );

      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(clipRRect.borderRadius, BorderRadius.zero);
    });

    testWidgets('applies padding', (tester) async {
      const padding = EdgeInsets.all(20);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              padding: padding,
              child: Text('Padded'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(BackdropFilter),
          matching: find.byType(Container),
        ),
      );

      expect(container.padding, padding);
    });

    testWidgets('uses zero padding by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              child: Text('Child'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(BackdropFilter),
          matching: find.byType(Container),
        ),
      );

      expect(container.padding, const EdgeInsets.all(0));
    });

    testWidgets('has border with semi-transparent white', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              child: Text('Child'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(BackdropFilter),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);
      expect((decoration.border as Border).top.width, 1);
    });

    testWidgets('wraps BackdropFilter in ClipRRect', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FrostedGlassContainer(
              child: Text('Child'),
            ),
          ),
        ),
      );

      final clipRRect = find.byType(ClipRRect);
      final backdropFilter = find.byType(BackdropFilter);

      expect(clipRRect, findsOneWidget);
      expect(
        find.descendant(of: clipRRect, matching: backdropFilter),
        findsOneWidget,
      );
    });
  });
}
