import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('FormattedTextField', () {
    testWidgets('renders a text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('displays initial value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              initialValue: 'Initial Text',
            ),
          ),
        ),
      );

      expect(find.text('Initial Text'), findsOneWidget);
    });

    testWidgets('forces lowercase when enabled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              initialValue: 'UPPERCASE',
              forceLowercase: true,
            ),
          ),
        ),
      );

      expect(find.text('uppercase'), findsOneWidget);
    });

    testWidgets('does not force lowercase by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              initialValue: 'MixedCase',
            ),
          ),
        ),
      );

      expect(find.text('MixedCase'), findsOneWidget);
    });

    testWidgets('calls onChanged when text changes', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'New Text');
      expect(changedValue, 'New Text');
    });

    testWidgets('onChanged receives lowercase when forceLowercase is true',
        (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              forceLowercase: true,
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'UPPERCASE');
      expect(changedValue, 'UPPERCASE'); // onChanged gets raw value
    });

    testWidgets('applies custom decoration', (tester) async {
      const decoration = InputDecoration(
        labelText: 'Custom Label',
        hintText: 'Hint',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              decoration: decoration,
            ),
          ),
        ),
      );

      expect(find.text('Custom Label'), findsOneWidget);
    });

    testWidgets('applies custom text style', (tester) async {
      const style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              style: style,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.style, style);
    });

    testWidgets('applies keyboard type', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.emailAddress);
    });

    testWidgets('obscures text when obscureText is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              obscureText: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
    });

    testWidgets('does not obscure text by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isFalse);
    });

    testWidgets('applies text capitalization', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              textCapitalization: TextCapitalization.words,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.textCapitalization, TextCapitalization.words);
    });

    testWidgets('applies max lines', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              maxLines: 3,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, 3);
    });

    testWidgets('uses single line by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, 1);
    });

    testWidgets('applies max length', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              maxLength: 10,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLength, 10);
    });

    testWidgets('applies input formatters', (tester) async {
      final formatters = <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              inputFormatters: formatters,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.inputFormatters, formatters);
    });

    testWidgets('applies text input action', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              textInputAction: TextInputAction.search,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.textInputAction, TextInputAction.search);
    });

    testWidgets('calls onSubmitted', (tester) async {
      String? submittedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              onSubmitted: (value) => submittedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Submit Test');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      expect(submittedValue, 'Submit Test');
    });

    testWidgets('applies autofocus', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              autofocus: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofocus, isTrue);
    });

    testWidgets('does not autofocus by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofocus, isFalse);
    });

    testWidgets('applies autocorrect setting', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              autocorrect: false,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autocorrect, isFalse);
    });

    testWidgets('autocorrect is true by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autocorrect, isTrue);
    });

    testWidgets('applies autofill hints', (tester) async {
      const autofillHints = [AutofillHints.email];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              autofillHints: autofillHints,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofillHints, autofillHints);
    });

    testWidgets('uses external controller when provided', (tester) async {
      final controller = TextEditingController(text: 'External');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('External'), findsOneWidget);

      controller.dispose();
    });

    testWidgets('updates when initialValue changes', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              initialValue: 'First',
            ),
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              initialValue: 'Second',
            ),
          ),
        ),
      );

      expect(find.text('Second'), findsOneWidget);
    });

    testWidgets('preserves cursor position when forceLowercase',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              forceLowercase: true,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Test');
      await tester.pump();

      expect(find.text('test'), findsOneWidget);
    });

    testWidgets('enables suggestions when autofillHints provided',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(
              autofillHints: [AutofillHints.username],
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enableSuggestions, isTrue);
    });

    testWidgets('disables suggestions when autofillHints is empty',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FormattedTextField(),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enableSuggestions, isFalse);
    });

    testWidgets(
        'toggles display between lowercase and original when forceLowercase changes',
        (tester) async {
      bool lowercase = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return FormattedTextField(
                  initialValue: 'BEANS',
                  forceLowercase: lowercase,
                );
              },
            ),
          ),
        ),
      );

      // Initially shows uppercase
      expect(find.text('BEANS'), findsOneWidget);
      expect(find.text('beans'), findsNothing);

      // Toggle on - should show lowercase
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return const FormattedTextField(
                  initialValue: 'BEANS',
                  forceLowercase: true,
                );
              },
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('beans'), findsOneWidget);
      expect(find.text('BEANS'), findsNothing);

      // Toggle off - should show uppercase again
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return const FormattedTextField(
                  initialValue: 'BEANS',
                  forceLowercase: false,
                );
              },
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('BEANS'), findsOneWidget);
      expect(find.text('beans'), findsNothing);
    });
  });
}
