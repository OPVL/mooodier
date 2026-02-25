import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('SurfaceCard', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SurfaceCard(
              child: Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    group('elevated variant', () {
      testWidgets('is the default variant', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                child: Text('Content'),
              ),
            ),
          ),
        );

        expect(find.byType(Container), findsWidgets);
      });

      testWidgets('has shadow', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                variant: SurfaceVariant.elevated,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SurfaceCard),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration as BoxDecoration;
        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow!.isNotEmpty, isTrue);
      });

      testWidgets('has no border', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                variant: SurfaceVariant.elevated,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SurfaceCard),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isNull);
      });
    });

    group('outlined variant', () {
      testWidgets('has border', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                variant: SurfaceVariant.outlined,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SurfaceCard),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isNotNull);
      });

      testWidgets('has no shadow', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                variant: SurfaceVariant.outlined,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SurfaceCard),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration as BoxDecoration;
        expect(decoration.boxShadow, isNull);
      });
    });

    group('glass variant', () {
      testWidgets('uses FrostedGlassContainer', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                variant: SurfaceVariant.glass,
                child: Text('Content'),
              ),
            ),
          ),
        );

        expect(find.byType(FrostedGlassContainer), findsOneWidget);
      });

      testWidgets('passes borderRadius to FrostedGlassContainer',
          (tester) async {
        const customRadius = BorderRadius.all(Radius.circular(20));

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                variant: SurfaceVariant.glass,
                borderRadius: customRadius,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final frostedGlass = tester.widget<FrostedGlassContainer>(
          find.byType(FrostedGlassContainer),
        );

        expect(frostedGlass.borderRadius, customRadius);
      });

      testWidgets('passes padding to FrostedGlassContainer', (tester) async {
        const customPadding = EdgeInsets.all(30);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                variant: SurfaceVariant.glass,
                padding: customPadding,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final frostedGlass = tester.widget<FrostedGlassContainer>(
          find.byType(FrostedGlassContainer),
        );

        expect(frostedGlass.padding, customPadding);
      });
    });

    group('padding', () {
      testWidgets('uses default card padding', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                child: Text('Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SurfaceCard),
                matching: find.byType(Container),
              )
              .first,
        );

        expect(container.padding, Spacings.cardPadding);
      });

      testWidgets('applies custom padding', (tester) async {
        const customPadding = EdgeInsets.all(50);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                padding: customPadding,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SurfaceCard),
                matching: find.byType(Container),
              )
              .first,
        );

        expect(container.padding, customPadding);
      });

      testWidgets('can use zero padding', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                padding: EdgeInsets.zero,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SurfaceCard),
                matching: find.byType(Container),
              )
              .first,
        );

        expect(container.padding, EdgeInsets.zero);
      });
    });

    group('margin', () {
      testWidgets('has no margin by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                child: Text('Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SurfaceCard),
                matching: find.byType(Container),
              )
              .first,
        );

        expect(container.margin, isNull);
      });

      testWidgets('applies custom margin', (tester) async {
        const customMargin = EdgeInsets.all(20);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                margin: customMargin,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SurfaceCard),
                matching: find.byType(Container),
              )
              .first,
        );

        expect(container.margin, customMargin);
      });
    });

    group('borderRadius', () {
      testWidgets('uses default large radius', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                child: Text('Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SurfaceCard),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration as BoxDecoration;
        expect(decoration.borderRadius, Radii.large);
      });

      testWidgets('applies custom borderRadius', (tester) async {
        const customRadius = BorderRadius.all(Radius.circular(30));

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SurfaceCard(
                borderRadius: customRadius,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SurfaceCard),
                matching: find.byType(Container),
              )
              .first,
        );

        final decoration = container.decoration as BoxDecoration;
        expect(decoration.borderRadius, customRadius);
      });
    });

    testWidgets('uses theme surface color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          home: const Scaffold(
            body: SurfaceCard(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(SurfaceCard),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, isNotNull);
    });
  });
}
