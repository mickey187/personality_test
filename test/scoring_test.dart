import 'package:flutter_test/flutter_test.dart';
import 'package:personality_test/data/mini_ipip_items.dart';
import 'package:personality_test/data/models/test_result.dart';
import 'package:personality_test/data/models/trait.dart';
import 'package:personality_test/domain/scoring.dart';

/// Builds an answer map that gives every item the same raw response.
Map<int, int> _uniform(int response) =>
    <int, int>{for (int id = 1; id <= 20; id++) id: response};

/// Builds answers that maximise every trait: positive items → 5, reverse
/// items → 1 (which flips to 5). Every trait should come out at 20.
Map<int, int> _maxEveryTrait() => <int, int>{
      for (final q in kMiniIpipItems) q.id: q.reverseScored ? 1 : 5,
    };

/// Mirror of [_maxEveryTrait]: minimises every trait to 4.
Map<int, int> _minEveryTrait() => <int, int>{
      for (final q in kMiniIpipItems) q.id: q.reverseScored ? 5 : 1,
    };

void main() {
  group('item bank integrity', () {
    test('has exactly 20 items with unique ids 1..20', () {
      expect(kMiniIpipItems.length, 20);
      expect(
        kMiniIpipItems.map((q) => q.id).toSet(),
        {for (int i = 1; i <= 20; i++) i},
      );
    });

    test('each trait has exactly 4 items', () {
      for (final Trait t in Trait.values) {
        expect(
          kMiniIpipItems.where((q) => q.trait == t).length,
          4,
          reason: '$t should have 4 items',
        );
      }
    });

    test('reverse-key count matches the official Mini-IPIP', () {
      // Official reverse-keyed item ids.
      const expectedReverse = {6, 7, 8, 9, 10, 15, 16, 17, 18, 19, 20};
      final actualReverse =
          kMiniIpipItems.where((q) => q.reverseScored).map((q) => q.id).toSet();
      expect(actualReverse, expectedReverse);
    });
  });

  group('scoreAnswers — reverse scoring', () {
    test('maximising every trait yields raw 20 across the board', () {
      final result = scoreAnswers(_maxEveryTrait());
      for (final Trait t in Trait.values) {
        expect(result[t].raw, 20, reason: '$t');
        expect(result[t].level, TraitLevel.high);
      }
    });

    test('minimising every trait yields raw 4 across the board', () {
      final result = scoreAnswers(_minEveryTrait());
      for (final Trait t in Trait.values) {
        expect(result[t].raw, 4, reason: '$t');
        expect(result[t].level, TraitLevel.low);
      }
    });

    test('all-neutral (3) yields raw 12 (mid) for every trait', () {
      final result = scoreAnswers(_uniform(3));
      for (final Trait t in Trait.values) {
        expect(result[t].raw, 12, reason: '$t');
        expect(result[t].level, TraitLevel.mid);
      }
    });

    test('all-1 responses expose reverse keying (Openness differs)', () {
      final result = scoreAnswers(_uniform(1));
      // 2 positive + 2 reverse -> 1+1+5+5 = 12 for E/A/C/N.
      expect(result[Trait.extraversion].raw, 12);
      expect(result[Trait.agreeableness].raw, 12);
      expect(result[Trait.conscientiousness].raw, 12);
      expect(result[Trait.neuroticism].raw, 12);
      // Openness is 1 positive + 3 reverse -> 1 + 5+5+5 = 16.
      expect(result[Trait.openness].raw, 16);
    });

    test('all-5 responses mirror all-1 (Openness -> 8)', () {
      final result = scoreAnswers(_uniform(5));
      expect(result[Trait.extraversion].raw, 12);
      expect(result[Trait.openness].raw, 8);
    });
  });

  group('scoreAnswers — validation', () {
    test('throws when an item is unanswered', () {
      final answers = _uniform(3)..remove(7);
      expect(() => scoreAnswers(answers), throwsArgumentError);
    });

    test('throws when a response is out of range', () {
      final answers = _uniform(3)..[7] = 6;
      expect(() => scoreAnswers(answers), throwsArgumentError);
    });

    test('throws when a response is below range', () {
      final answers = _uniform(3)..[7] = 0;
      expect(() => scoreAnswers(answers), throwsArgumentError);
    });
  });

  group('ScoreBands.levelFor boundaries', () {
    test('low band is 4..9', () {
      expect(ScoreBands.levelFor(4), TraitLevel.low);
      expect(ScoreBands.levelFor(9), TraitLevel.low);
    });
    test('mid band is 10..14', () {
      expect(ScoreBands.levelFor(10), TraitLevel.mid);
      expect(ScoreBands.levelFor(14), TraitLevel.mid);
    });
    test('high band is 15..20', () {
      expect(ScoreBands.levelFor(15), TraitLevel.high);
      expect(ScoreBands.levelFor(20), TraitLevel.high);
    });
  });

  group('TraitScore derived values', () {
    test('average and normalized are correct', () {
      const min = TraitScore(trait: Trait.openness, raw: 4);
      const max = TraitScore(trait: Trait.openness, raw: 20);
      const mid = TraitScore(trait: Trait.openness, raw: 12);
      expect(min.average, 1.0);
      expect(max.average, 5.0);
      expect(min.normalized, 0.0);
      expect(max.normalized, 1.0);
      expect(mid.normalized, closeTo(0.5, 1e-9));
    });
  });

  group('TestResult serialisation', () {
    test('round-trips through JSON', () {
      final original = scoreAnswers(
        _maxEveryTrait(),
        completedAt: DateTime.parse('2026-09-05T10:00:00.000'),
      );
      final restored = TestResult.fromJson(original.toJson());
      expect(restored.completedAt, original.completedAt);
      for (final Trait t in Trait.values) {
        expect(restored[t].raw, original[t].raw);
      }
    });
  });
}
