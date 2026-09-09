import '../data/learning_items.dart';
import '../data/models/learning.dart';
import 'scoring.dart' show kLikertMin, kLikertMax;

/// Scores a completed set of Learning Style answers.
///
/// [answers] maps a [LearningItem.id] (1–20) to the raw agreement response
/// (1–5). Items are all positively keyed, so each mode's raw score is the sum
/// of its 5 responses (range 5–25).
LearningResult scoreLearning(
  Map<int, int> answers, {
  List<LearningItem> items = kLearningItems,
  DateTime? completedAt,
}) {
  final Map<LearningStyle, int> sums = <LearningStyle, int>{
    for (final LearningStyle s in LearningStyle.values) s: 0,
  };

  for (final LearningItem item in items) {
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
    sums[item.style] = sums[item.style]! + response;
  }

  return LearningResult(
    completedAt: completedAt ?? DateTime.now(),
    scores: sums,
  );
}
