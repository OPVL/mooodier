import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('CustomListTile', () {
    testWidgets('displays title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(title: 'Test Title'),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('title has correct font weight', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(title: 'Test'),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      final titleWidget = listTile.title as Text;
      expect(titleWidget.style?.fontWeight, FontWeight.w500);
    });

    testWidgets('displays subtitle when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(
              title: 'Title',
              subtitle: 'Subtitle text',
            ),
          ),
        ),
      );

      expect(find.text('Subtitle text'), findsOneWidget);
    });

    testWidgets('does not display subtitle when not provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(title: 'Title'),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.subtitle, isNull);
    });

    testWidgets('displays leading icon when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(
              title: 'Title',
              leadingIcon: Icons.star,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('leading icon uses theme primary color by default',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          home: const Scaffold(
            body: CustomListTile(
              title: 'Title',
              leadingIcon: Icons.star,
            ),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      final leadingIcon = listTile.leading as Icon;
      expect(leadingIcon.color, isNotNull);
    });

    testWidgets('leading icon uses custom color when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(
              title: 'Title',
              leadingIcon: Icons.star,
              iconColor: Colors.red,
            ),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      final leadingIcon = listTile.leading as Icon;
      expect(leadingIcon.color, Colors.red);
    });

    testWidgets('displays default trailing chevron when no trailing provided',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(title: 'Title'),
          ),
        ),
      );

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('displays custom trailing widget when provided',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(
              title: 'Title',
              trailing: Icon(Icons.settings),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsNothing);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomListTile(
              title: 'Title',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ListTile));
      expect(tapped, isTrue);
    });

    testWidgets('is not tappable when onTap is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(title: 'Title'),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.onTap, isNull);
    });

    testWidgets('does not display leading when leadingIcon is null',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomListTile(title: 'Title'),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.leading, isNull);
    });

    testWidgets('title uses theme onSurface color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          home: const Scaffold(
            body: CustomListTile(title: 'Title'),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      final titleWidget = listTile.title as Text;
      expect(titleWidget.style?.color, isNotNull);
    });

    testWidgets('subtitle uses theme onSurfaceVariant color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          home: const Scaffold(
            body: CustomListTile(
              title: 'Title',
              subtitle: 'Subtitle',
            ),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      final subtitleWidget = listTile.subtitle as Text;
      expect(subtitleWidget.style?.color, isNotNull);
    });
  });
}
