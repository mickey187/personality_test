import 'package:flutter_test/flutter_test.dart';
import 'package:personality_test/data/leadership_items.dart';
import 'package:personality_test/data/learning_items.dart';
import 'package:personality_test/data/love_items.dart';
import 'package:personality_test/data/models/leadership.dart';
import 'package:personality_test/data/models/learning.dart';
import 'package:personality_test/data/models/love.dart';
import 'package:personality_test/domain/leadership_scoring.dart';
import 'package:personality_test/domain/learning_scoring.dart';
import 'package:personality_test/domain/love_scoring.dart';

void main() {
  group('Love Language', () {
    test('25 items, 5 per language, ids 1..25', () {
      expect(kLoveItems.length, 25);
      for (final LoveLanguage l in LoveLanguage.values) {
        expect(kLoveItems.where((i) => i.language == l).length, 5);
      }
      expect(kLoveItems.map((i) => i.id).toSet(),
          <int>{for (int i = 1; i <= 25; i++) i});
    });

    test('all-5 maxes every language; ranking follows the boosted one', () {
      final r = scoreLove(<int, int>{for (final i in kLoveItems) i.id: 5});
      for (final l in LoveLanguage.values) {
        expect(r[l], 25);
        expect(r.percentFor(l), 100);
      }
      final boosted = <int, int>{
        for (final i in kLoveItems)
          i.id: i.language == LoveLanguage.physicalTouch ? 5 : 2,
      };
      final r2 = scoreLove(boosted);
      expect(r2.primary, LoveLanguage.physicalTouch);
    });

    test('validation throws; JSON round-trips', () {
      expect(() => scoreLove(<int, int>{}), throwsArgumentError);
      final r = scoreLove(<int, int>{for (final i in kLoveItems) i.id: 4});
      final back = LoveResult.fromJson(r.toJson());
      expect(back.primary, r.primary);
      for (final l in LoveLanguage.values) {
        expect(back[l], r[l]);
      }
    });
  });

  group('Leadership Style', () {
    test('36 items, 6 per style, ids 1..36', () {
      expect(kLeadershipItems.length, 36);
      for (final LeadershipStyle s in LeadershipStyle.values) {
        expect(kLeadershipItems.where((i) => i.style == s).length, 6);
      }
      expect(kLeadershipItems.map((i) => i.id).toSet(),
          <int>{for (int i = 1; i <= 36; i++) i});
    });

    test('all-5 maxes every style (raw 30); dominant follows boost', () {
      final r =
          scoreLeadership(<int, int>{for (final i in kLeadershipItems) i.id: 5});
      for (final s in LeadershipStyle.values) {
        expect(r[s], 30);
      }
      final boosted = <int, int>{
        for (final i in kLeadershipItems)
          i.id: i.style == LeadershipStyle.coaching ? 5 : 2,
      };
      expect(scoreLeadership(boosted).dominant, LeadershipStyle.coaching);
    });

    test('validation throws; JSON round-trips', () {
      final bad = <int, int>{for (final i in kLeadershipItems) i.id: 3}..[1] = 7;
      expect(() => scoreLeadership(bad), throwsArgumentError);
      final r =
          scoreLeadership(<int, int>{for (final i in kLeadershipItems) i.id: 4});
      final back = LeadershipResult.fromJson(r.toJson());
      expect(back.dominant, r.dominant);
    });
  });

  group('Learning Style', () {
    test('20 items, 5 per mode, ids 1..20', () {
      expect(kLearningItems.length, 20);
      for (final LearningStyle s in LearningStyle.values) {
        expect(kLearningItems.where((i) => i.style == s).length, 5);
      }
      expect(kLearningItems.map((i) => i.id).toSet(),
          <int>{for (int i = 1; i <= 20; i++) i});
    });

    test('primary follows the boosted mode; JSON round-trips', () {
      final boosted = <int, int>{
        for (final i in kLearningItems)
          i.id: i.style == LearningStyle.kinesthetic ? 5 : 2,
      };
      final r = scoreLearning(boosted);
      expect(r.primary, LearningStyle.kinesthetic);
      final back = LearningResult.fromJson(r.toJson());
      expect(back.primary, r.primary);
      for (final s in LearningStyle.values) {
        expect(back[s], r[s]);
      }
    });

    test('validation throws on missing/out-of-range', () {
      expect(() => scoreLearning(<int, int>{}), throwsArgumentError);
    });
  });
}
