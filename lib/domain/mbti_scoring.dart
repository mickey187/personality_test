import '../data/mbti_items.dart';
import '../data/models/mbti.dart';
import 'scoring.dart' show kLikertMin, kLikertMax;

/// Scores a completed set of personality-type answers.
///
/// [answers] maps an [MbtiItem.id] to the raw Likert response (1 = strongly
/// disagree, 5 = strongly agree). Each pole sums the items tagged with it;
/// because poles within an axis can have an uneven item count (e.g. 4 vs 3),
/// [MbtiResult] decides each axis's winner by per-item mean, not raw sum —
/// this function just does the summing and records the counts needed for
/// that normalization.
///
/// Throws [ArgumentError] if any item is missing or any response is out of
/// the 1–5 range — callers must only score a fully-answered test.
MbtiResult scoreMbti(
  Map<int, int> answers, {
  List<MbtiItem> items = kMbtiItems,
  DateTime? completedAt,
}) {
  final Map<MbtiPole, int> sums = <MbtiPole, int>{
    for (final MbtiPole p in MbtiPole.values) p: 0,
  };
  final Map<MbtiPole, int> counts = <MbtiPole, int>{
    for (final MbtiPole p in MbtiPole.values) p: 0,
  };

  for (final MbtiItem item in items) {
    final int? response = answers[item.id];
    if (response == null) {
      throw ArgumentError('Missing answer for item ${item.id}');
    }
    if (response < kLikertMin || response > kLikertMax) {
      throw ArgumentError(
        'Response for item ${item.id} out of range ($kLikertMin–$kLikertMax): '
        '$response',
      );
    }
    sums[item.pole] = sums[item.pole]! + response;
    counts[item.pole] = counts[item.pole]! + 1;
  }

  return MbtiResult(
    completedAt: completedAt ?? DateTime.now(),
    poleScores: sums,
    poleCounts: counts,
  );
}
