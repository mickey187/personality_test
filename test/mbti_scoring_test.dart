import 'package:flutter_test/flutter_test.dart';
import 'package:personality_test/data/mbti_items.dart';
import 'package:personality_test/data/models/mbti.dart';
import 'package:personality_test/domain/mbti_scoring.dart';

/// Builds an answer map giving every item [value].
Map<int, int> _allAnswers(int value) => <int, int>{
      for (final MbtiItem item in kMbtiItems) item.id: value,
    };

void main() {
  test('there are 28 items, 7 per axis', () {
    expect(kMbtiItems.length, 28);
    for (final MbtiAxis axis in MbtiAxis.values) {
      final int count =
          kMbtiItems.where((MbtiItem i) => i.pole.axis == axis).length;
      expect(count, 7, reason: 'expected 7 items for $axis');
    }
  });

  test('each pole has at least 2 items, and axis-pole counts differ by at '
      'most 1', () {
    for (final MbtiAxis axis in MbtiAxis.values) {
      final List<MbtiPole> poles =
          MbtiPole.values.where((MbtiPole p) => p.axis == axis).toList();
      final int countA =
          kMbtiItems.where((MbtiItem i) => i.pole == poles[0]).length;
      final int countB =
          kMbtiItems.where((MbtiItem i) => i.pole == poles[1]).length;
      expect(countA, greaterThanOrEqualTo(2));
      expect(countB, greaterThanOrEqualTo(2));
      expect((countA - countB).abs(), lessThanOrEqualTo(1));
    }
  });

  test('item ids are unique and cover 1..28', () {
    final Set<int> ids = kMbtiItems.map((MbtiItem i) => i.id).toSet();
    expect(ids.length, 28);
    expect(ids, <int>{for (int i = 1; i <= 28; i++) i});
  });

  test('all-neutral answers tie every axis, resolving to the canonical '
      'first pole (E, S, T, J)', () {
    final MbtiResult r = scoreMbti(_allAnswers(3));
    expect(r.typeCode, 'ESTJ');
  });

  test('maxing one pole and mining its partner gives the maximum possible '
      'strength (5/(5+1) = 83%) for the winning pole', () {
    final Map<int, int> answers = <int, int>{
      for (final MbtiItem i in kMbtiItems)
        i.id: i.pole == MbtiPole.i ? 5 : (i.pole == MbtiPole.e ? 1 : 3),
    };
    final MbtiResult r = scoreMbti(answers);
    expect(r.winnerFor(MbtiAxis.ei), MbtiPole.i);
    expect(r.strengthPercentFor(MbtiAxis.ei), 83);
  });

  test('uneven pole counts do not bias the axis winner: per-item mean, not '
      'raw sum, decides', () {
    // E has 4 items, I has 3 items (see kMbtiItems). Give all I items a 5
    // and all E items a 4: raw sums are E=16, I=15 (E ahead on raw sum), but
    // I's per-item mean (5) beats E's per-item mean (4) — I must win.
    final Map<int, int> answers = <int, int>{
      for (final MbtiItem i in kMbtiItems)
        i.id: switch (i.pole) {
          MbtiPole.e => 4,
          MbtiPole.i => 5,
          _ => 3,
        },
    };
    final MbtiResult r = scoreMbti(answers);
    expect(r.poleScores[MbtiPole.e], 16);
    expect(r.poleScores[MbtiPole.i], 15);
    expect(r.winnerFor(MbtiAxis.ei), MbtiPole.i);
  });

  test('missing answers and out-of-range responses throw', () {
    expect(() => scoreMbti(<int, int>{}), throwsArgumentError);
    final Map<int, int> bad = _allAnswers(3)..[1] = 0;
    expect(() => scoreMbti(bad), throwsArgumentError);
  });

  test('a result round-trips through JSON', () {
    final MbtiResult r = scoreMbti(_allAnswers(4));
    final MbtiResult back = MbtiResult.fromJson(r.toJson());
    for (final MbtiPole pole in MbtiPole.values) {
      expect(back.poleScores[pole], r.poleScores[pole]);
      expect(back.poleCounts[pole], r.poleCounts[pole]);
    }
    expect(back.typeCode, r.typeCode);
  });
}
