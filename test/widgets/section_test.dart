import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('Section', () {
    testWidgets('displays title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Section(
              title: 'Test Section',
              children: [Text('Child 1')],
            ),
          ),
        ),
      );

      expect(find.text('Test Section'), findsOneWidget);
    });

    testWidgets('displays all children', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Section(
              title: 'Test',
              children: [
                Text('Child 1'),
                Text('Child 2'),
                Text('Child 3'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('Child 2'), findsOneWidget);
      expect(find.text('Child 3'), findsOneWidget);
    });

    testWidgets('uses default padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Section(
              title: 'Test',
              children: [Text('Child')],
            ),
          ),
        ),
      );

      final padding = tester.widget<Section>(find.byType(Section)).padding;
      expect(padding, Spacings.sectionPadding);
    });

    testWidgets('applies custom padding', (tester) async {
      const customPadding = EdgeInsets.all(20);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Section(
              title: 'Test',
              padding: customPadding,
              children: [Text('Child')],
            ),
          ),
        ),
      );

      final padding = tester.widget<Section>(find.byType(Section)).padding;
      expect(padding, customPadding);
    });

    testWidgets('includes SectionHeader', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Section(
              title: 'Test',
              children: [Text('Child')],
            ),
          ),
        ),
      );

      expect(find.byType(SectionHeader), findsOneWidget);
    });

    testWidgets('passes trailing to SectionHeader', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Section(
              title: 'Test',
              trailing: Icon(Icons.settings),
              children: [Text('Child')],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('arranges children in a column', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Section(
              title: 'Test',
              children: [
                Text('Child 1'),
                Text('Child 2'),
              ],
            ),
          ),
        ),
      );

      final column = tester.widget<Column>(find.byType(Column));
      // Column should have header + children
      expect(column.children.length, 3); // SectionHeader + 2 children
    });

    testWidgets('has correct cross axis alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Section(
              title: 'Test',
              children: [Text('Child')],
            ),
          ),
        ),
      );

      final column = tester.widget<Column>(find.byType(Column));
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
    });

    testWidgets('handles empty children list', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Section(
              title: 'Test',
              children: [],
            ),
          ),
        ),
      );

      expect(find.byType(SectionHeader), findsOneWidget);
      final column = tester.widget<Column>(find.byType(Column));
      expect(column.children.length, 1); // Just the header
    });
  });
}
