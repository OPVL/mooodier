import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('Durations', () {
    test('fast duration is 180ms', () {
      expect(Durations.fast, const Duration(milliseconds: 180));
      expect(Durations.fast.inMilliseconds, 180);
    });

    test('normal duration is 280ms', () {
      expect(Durations.normal, const Duration(milliseconds: 280));
      expect(Durations.normal.inMilliseconds, 280);
    });

    test('slow duration is 420ms', () {
      expect(Durations.slow, const Duration(milliseconds: 420));
      expect(Durations.slow.inMilliseconds, 420);
    });

    test('gradientCycle duration is 20 seconds', () {
      expect(Durations.gradientCycle, const Duration(seconds: 20));
      expect(Durations.gradientCycle.inSeconds, 20);
      expect(Durations.gradientCycle.inMilliseconds, 20000);
    });

    test('durations are in ascending order', () {
      expect(Durations.fast < Durations.normal, isTrue);
      expect(Durations.normal < Durations.slow, isTrue);
      expect(Durations.slow < Durations.gradientCycle, isTrue);
    });

    test('all durations are positive', () {
      expect(Durations.fast.inMilliseconds, greaterThan(0));
      expect(Durations.normal.inMilliseconds, greaterThan(0));
      expect(Durations.slow.inMilliseconds, greaterThan(0));
      expect(Durations.gradientCycle.inMilliseconds, greaterThan(0));
    });
  });
}
