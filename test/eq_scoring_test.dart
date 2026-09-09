import 'package:flutter_test/flutter_test.dart';
import 'package:personality_test/data/eq_items.dart';
import 'package:personality_test/data/models/eq.dart';
import 'package:personality_test/domain/eq_scoring.dart';

/// Builds an answer map giving every item [value].
Map<int, int> _allAnswers(int value) => <int, int>{
      for (final EqItem item in kEqItems) item.id: value,
    };

void main() {
  test('there are 40 items, 10 per EQ dimension', () {
    expect(kEqItems.length, 40);
    for (final EqDimension dim in EqDimension.values) {
      final int count =
          kEqItems.where((EqItem i) => i.dimension == dim).length;
      expect(count, 10, reason: 'expected 10 items for $dim');
    }
  });

  test('item ids are unique and cover 1..40', () {
    final Set<int> ids = kEqItems.map((EqItem i) => i.id).toSet();
    expect(ids.length, 40);
    expect(ids, <int>{for (int i = 1; i <= 40; i++) i});
  });

  test('every dimension has some reverse-keyed items', () {
    for (final EqDimension dim in EqDimension.values) {
      final bool anyReverse = kEqItems
          .where((EqItem i) => i.dimension == dim)
          .any((EqItem i) => i.reverseScored);
      expect(anyReverse, isTrue, reason: '$dim should have a reverse item');
    }
  });

  test('all-strongly-agree maxes forward items but reverse items pull down', () {
    // With reverse items, answering 5 everywhere does NOT max a dimension: the
    // reverse items score (6 - 5) = 1. So each dimension = forward*5 + reverse*1.
    final EqResult r = scoreEq(_allAnswers(5));
    for (final EqDimension dim in EqDimension.values) {
      final int reverse = kEqItems
          .where((EqItem i) => i.dimension == dim && i.reverseScored)
          .length;
      final int forward = 10 - reverse;
      expect(r[dim], forward * 5 + reverse * 1);
    }
  });

  test('a consistent responder (agree forward, disagree reverse) maxes out', () {
    final Map<int, int> answers = <int, int>{
      for (final EqItem i in kEqItems) i.id: i.reverseScored ? 1 : 5,
    };
    final EqResult r = scoreEq(answers);
    for (final EqDimension dim in EqDimension.values) {
      expect(r[dim], EqBands.maxRaw);
      expect(r.percentFor(dim), 100);
    }
    expect(r.overall, EqBands.overallMax);
    expect(r.overallPercent, 100);
    expect(r.overallLevel, EqLevel.high);
  });

  test('all-neutral gives a mid overall band', () {
    final EqResult r = scoreEq(_allAnswers(3));
    for (final EqDimension dim in EqDimension.values) {
      expect(r[dim], 30); // 10 items × 3, reverse flips 3→3
    }
    expect(r.overallLevel, EqLevel.mid);
  });

  test('missing answers and out-of-range responses throw', () {
    expect(() => scoreEq(<int, int>{}), throwsArgumentError);
    final Map<int, int> bad = _allAnswers(3)..[1] = 0;
    expect(() => scoreEq(bad), throwsArgumentError);
  });

  test('a result round-trips through JSON', () {
    final EqResult r = scoreEq(_allAnswers(4));
    final EqResult back = EqResult.fromJson(r.toJson());
    for (final EqDimension dim in EqDimension.values) {
      expect(back[dim], r[dim]);
    }
    expect(back.overall, r.overall);
  });
}
