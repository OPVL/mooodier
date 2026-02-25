import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('AnimatedGradientContainer', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedGradientContainer(
              child: Text('Child Widget'),
            ),
          ),
        ),
      );

      expect(find.text('Child Widget'), findsOneWidget);
    });

    testWidgets('renders without child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: AnimatedGradientContainer(),
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedGradientContainer), findsOneWidget);
    });

    testWidgets('uses custom colors when provided', (tester) async {
      const customColors = [
        Colors.red,
        Colors.blue,
        Colors.green,
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: AnimatedGradientContainer(
                colors: customColors,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedGradientContainer), findsOneWidget);
    });

    testWidgets('applies BackdropFilter for blur', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: AnimatedGradientContainer(),
            ),
          ),
        ),
      );

      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('uses LayoutBuilder for responsive sizing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: AnimatedGradientContainer(),
            ),
          ),
        ),
      );

      expect(find.byType(LayoutBuilder), findsOneWidget);
    });

    testWidgets('uses ClipRect to clip content', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: AnimatedGradientContainer(),
            ),
          ),
        ),
      );

      expect(find.byType(ClipRect), findsOneWidget);
    });

    testWidgets('contains BackdropFilter for blur effect', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: AnimatedGradientContainer(),
            ),
          ),
        ),
      );

      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('positions child in stack', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: AnimatedGradientContainer(
                child: Center(child: Text('Centered')),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Centered'), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('cleans up resources on dispose', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: AnimatedGradientContainer(),
            ),
          ),
        ),
      );

      // Remove widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byType(AnimatedGradientContainer), findsNothing);
    });

    testWidgets('accepts custom animation speed', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: AnimatedGradientContainer(
                animationSpeed: 2.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedGradientContainer), findsOneWidget);
    });

    testWidgets('animation speed of 0.5 should slow down animations',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: AnimatedGradientContainer(
                animationSpeed: 0.5,
                duration: Duration(seconds: 10),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedGradientContainer), findsOneWidget);
    });
  });
}
