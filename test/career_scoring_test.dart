import 'package:flutter_test/flutter_test.dart';
import 'package:personality_test/data/career_items.dart';
import 'package:personality_test/data/models/riasec.dart';
import 'package:personality_test/domain/career_scoring.dart';

/// Builds an answer map giving every item [value].
Map<int, int> _allAnswers(int value) => <int, int>{
      for (final CareerItem item in kCareerItems) item.id: value,
    };

void main() {
  test('there are 48 items, 8 per RIASEC area', () {
    expect(kCareerItems.length, 48);
    for (final RiasecArea area in RiasecArea.values) {
      final int count =
          kCareerItems.where((CareerItem i) => i.area == area).length;
      expect(count, 8, reason: 'expected 8 items for $area');
    }
  });

  test('item ids are unique and cover 1..48', () {
    final Set<int> ids = kCareerItems.map((CareerItem i) => i.id).toSet();
    expect(ids.length, 48);
    expect(ids, <int>{for (int i = 1; i <= 48; i++) i});
  });

  test('all-strongly-like scores every area at the maximum (40 / 100%)', () {
    final CareerResult r = scoreCareer(_allAnswers(5));
    for (final RiasecArea area in RiasecArea.values) {
      expect(r[area], CareerBands.maxRaw);
      expect(r.percentFor(area), 100);
    }
  });

  test('all-strongly-dislike scores every area at the minimum (8)', () {
    final CareerResult r = scoreCareer(_allAnswers(1));
    for (final RiasecArea area in RiasecArea.values) {
      expect(r[area], CareerBands.minRaw);
    }
  });

  test('ranking and Holland code follow the strongest areas', () {
    // Start everyone neutral, then boost Social > Artistic > Enterprising.
    final Map<int, int> answers = _allAnswers(3);
    for (final CareerItem item in kCareerItems) {
      switch (item.area) {
        case RiasecArea.social:
          answers[item.id] = 5;
        case RiasecArea.artistic:
          answers[item.id] = 4;
        case RiasecArea.enterprising:
          answers[item.id] = 4;
        default:
          break;
      }
    }

    final CareerResult r = scoreCareer(answers);
    expect(r.ranked.first, RiasecArea.social);
    // Artistic and Enterprising tie on raw score; canonical R-I-A-S-E-C order
    // breaks the tie so Artistic ranks ahead of Enterprising.
    expect(r.ranked[1], RiasecArea.artistic);
    expect(r.ranked[2], RiasecArea.enterprising);
    expect(r.hollandCode, 'SAE');
  });

  test('missing answers and out-of-range responses throw', () {
    expect(() => scoreCareer(<int, int>{}), throwsArgumentError);
    final Map<int, int> bad = _allAnswers(3)..[1] = 9;
    expect(() => scoreCareer(bad), throwsArgumentError);
  });

  test('a result round-trips through JSON', () {
    final CareerResult r = scoreCareer(_allAnswers(4));
    final CareerResult back = CareerResult.fromJson(r.toJson());
    for (final RiasecArea area in RiasecArea.values) {
      expect(back[area], r[area]);
    }
    expect(back.hollandCode, r.hollandCode);
  });
}
