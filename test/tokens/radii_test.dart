import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('Radii', () {
    group('radius values', () {
      test('sm is 8', () {
        expect(Radii.sm, 8);
      });

      test('md is 12', () {
        expect(Radii.md, 12);
      });

      test('lg is 16', () {
        expect(Radii.lg, 16);
      });

      test('xl is 24', () {
        expect(Radii.xl, 24);
      });

      test('pill is 28', () {
        expect(Radii.pill, 28);
      });

      test('values are in ascending order', () {
        expect(Radii.sm < Radii.md, isTrue);
        expect(Radii.md < Radii.lg, isTrue);
        expect(Radii.lg < Radii.xl, isTrue);
        expect(Radii.xl < Radii.pill, isTrue);
      });

      test('all values are positive', () {
        expect(Radii.sm, greaterThan(0));
        expect(Radii.md, greaterThan(0));
        expect(Radii.lg, greaterThan(0));
        expect(Radii.xl, greaterThan(0));
        expect(Radii.pill, greaterThan(0));
      });
    });

    group('BorderRadius constants', () {
      test('small uses sm radius', () {
        expect(
          Radii.small,
          const BorderRadius.all(Radius.circular(Radii.sm)),
        );
        expect(Radii.small.topLeft.x, Radii.sm);
        expect(Radii.small.topRight.x, Radii.sm);
        expect(Radii.small.bottomLeft.x, Radii.sm);
        expect(Radii.small.bottomRight.x, Radii.sm);
      });

      test('medium uses md radius', () {
        expect(
          Radii.medium,
          const BorderRadius.all(Radius.circular(Radii.md)),
        );
        expect(Radii.medium.topLeft.x, Radii.md);
        expect(Radii.medium.topRight.x, Radii.md);
        expect(Radii.medium.bottomLeft.x, Radii.md);
        expect(Radii.medium.bottomRight.x, Radii.md);
      });

      test('large uses lg radius', () {
        expect(
          Radii.large,
          const BorderRadius.all(Radius.circular(Radii.lg)),
        );
        expect(Radii.large.topLeft.x, Radii.lg);
        expect(Radii.large.topRight.x, Radii.lg);
        expect(Radii.large.bottomLeft.x, Radii.lg);
        expect(Radii.large.bottomRight.x, Radii.lg);
      });

      test('extraLarge uses xl radius', () {
        expect(
          Radii.extraLarge,
          const BorderRadius.all(Radius.circular(Radii.xl)),
        );
        expect(Radii.extraLarge.topLeft.x, Radii.xl);
        expect(Radii.extraLarge.topRight.x, Radii.xl);
        expect(Radii.extraLarge.bottomLeft.x, Radii.xl);
        expect(Radii.extraLarge.bottomRight.x, Radii.xl);
      });

      test('all corners have same radius', () {
        expect(Radii.small.topLeft, Radii.small.topRight);
        expect(Radii.small.topLeft, Radii.small.bottomLeft);
        expect(Radii.small.topLeft, Radii.small.bottomRight);

        expect(Radii.medium.topLeft, Radii.medium.topRight);
        expect(Radii.large.topLeft, Radii.large.bottomLeft);
        expect(Radii.extraLarge.topRight, Radii.extraLarge.bottomRight);
      });
    });
  });
}
