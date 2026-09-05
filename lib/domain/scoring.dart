import '../data/mini_ipip_items.dart';
import '../data/models/question.dart';
import '../data/models/test_result.dart';
import '../data/models/trait.dart';

/// Minimum and maximum valid Likert response (1 = very inaccurate,
/// 5 = very accurate).
const int kLikertMin = 1;
const int kLikertMax = 5;

/// Scores a completed set of Mini-IPIP answers.
///
/// [answers] maps a [Question.id] (1–20) to the raw Likert response (1–5).
/// Reverse-keyed items are flipped with (6 − response) before summing, per the
/// official Mini-IPIP scoring. Returns a [TestResult] with a raw 4–20 sum per
/// trait.
///
/// Throws [ArgumentError] if any item is missing or any response is out of the
/// 1–5 range — callers must only score a fully-answered test.
TestResult scoreAnswers(
  Map<int, int> answers, {
  List<Question> items = kMiniIpipItems,
  DateTime? completedAt,
}) {
  final Map<Trait, int> sums = <Trait, int>{
    for (final Trait t in Trait.values) t: 0,
  };

  for (final Question q in items) {
    final int? response = answers[q.id];
    if (response == null) {
      throw ArgumentError('Missing answer for item ${q.id}');
    }
    if (response < kLikertMin || response > kLikertMax) {
      throw ArgumentError(
        'Response for item ${q.id} out of range ($kLikertMin–$kLikertMax): '
        '$response',
      );
    }
    final int scored = q.reverseScored ? (kLikertMax + kLikertMin) - response : response;
    sums[q.trait] = sums[q.trait]! + scored;
  }

  return TestResult(
    completedAt: completedAt ?? DateTime.now(),
    scores: <Trait, TraitScore>{
      for (final MapEntry<Trait, int> e in sums.entries)
        e.key: TraitScore(trait: e.key, raw: e.value),
    },
  );
}
