import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('Spacings', () {
    group('spacing values', () {
      test('xs is 4', () {
        expect(Spacings.xs, 4);
      });

      test('sm is 8', () {
        expect(Spacings.sm, 8);
      });

      test('md is 12', () {
        expect(Spacings.md, 12);
      });

      test('lg is 16', () {
        expect(Spacings.lg, 16);
      });

      test('xl is 24', () {
        expect(Spacings.xl, 24);
      });

      test('xxl is 32', () {
        expect(Spacings.xxl, 32);
      });

      test('values are in ascending order', () {
        expect(Spacings.xs < Spacings.sm, isTrue);
        expect(Spacings.sm < Spacings.md, isTrue);
        expect(Spacings.md < Spacings.lg, isTrue);
        expect(Spacings.lg < Spacings.xl, isTrue);
        expect(Spacings.xl < Spacings.xxl, isTrue);
      });

      test('all values are positive', () {
        expect(Spacings.xs, greaterThan(0));
        expect(Spacings.sm, greaterThan(0));
        expect(Spacings.md, greaterThan(0));
        expect(Spacings.lg, greaterThan(0));
        expect(Spacings.xl, greaterThan(0));
        expect(Spacings.xxl, greaterThan(0));
      });
    });

    group('EdgeInsets constants', () {
      test('screenPadding uses xl spacing', () {
        expect(Spacings.screenPadding, const EdgeInsets.all(Spacings.xl));
        expect(Spacings.screenPadding.left, Spacings.xl);
        expect(Spacings.screenPadding.top, Spacings.xl);
        expect(Spacings.screenPadding.right, Spacings.xl);
        expect(Spacings.screenPadding.bottom, Spacings.xl);
      });

      test('cardPadding uses lg spacing', () {
        expect(Spacings.cardPadding, const EdgeInsets.all(Spacings.lg));
        expect(Spacings.cardPadding.left, Spacings.lg);
        expect(Spacings.cardPadding.top, Spacings.lg);
        expect(Spacings.cardPadding.right, Spacings.lg);
        expect(Spacings.cardPadding.bottom, Spacings.lg);
      });

      test('sectionPadding has bottom padding only', () {
        expect(
          Spacings.sectionPadding,
          const EdgeInsets.only(bottom: Spacings.lg),
        );
        expect(Spacings.sectionPadding.left, 0);
        expect(Spacings.sectionPadding.top, 0);
        expect(Spacings.sectionPadding.right, 0);
        expect(Spacings.sectionPadding.bottom, Spacings.lg);
      });

      test('screen padding is larger than card padding', () {
        expect(Spacings.screenPadding.left,
            greaterThan(Spacings.cardPadding.left));
        expect(
            Spacings.screenPadding.top, greaterThan(Spacings.cardPadding.top));
      });
    });
  });
}
