import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('FormattedText', () {
    testWidgets('displays text as provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedText('Hello World'),
          ),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('applies lowercase when forceLowercase is true',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedText(
              'Hello World',
              forceLowercase: true,
            ),
          ),
        ),
      );

      expect(find.text('hello world'), findsOneWidget);
      expect(find.text('Hello World'), findsNothing);
    });

    testWidgets('does not apply lowercase by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedText('Hello World'),
          ),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
      expect(find.text('hello world'), findsNothing);
    });

    testWidgets('applies custom style', (tester) async {
      const style = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedText(
              'Styled Text',
              style: style,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Styled Text'));
      expect(textWidget.style?.fontSize, 24);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('applies text alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedText(
              'Centered Text',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Centered Text'));
      expect(textWidget.textAlign, TextAlign.center);
    });

    testWidgets('handles empty text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedText(''),
          ),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('forceLowercase works with mixed case', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedText(
              'MiXeD CaSe TeXt',
              forceLowercase: true,
            ),
          ),
        ),
      );

      expect(find.text('mixed case text'), findsOneWidget);
    });

    testWidgets('forceLowercase works with uppercase', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedText(
              'UPPERCASE',
              forceLowercase: true,
            ),
          ),
        ),
      );

      expect(find.text('uppercase'), findsOneWidget);
    });
  });
}
