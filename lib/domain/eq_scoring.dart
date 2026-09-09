import '../data/eq_items.dart';
import '../data/models/eq.dart';
import 'scoring.dart' show kLikertMin, kLikertMax;

/// Scores a completed set of EQ answers.
///
/// [answers] maps an [EqItem.id] (1–40) to the raw Likert response (1 = strongly
/// disagree, 5 = strongly agree). Reverse-keyed items are flipped (6 − response)
/// before summing, so a high score always means more of that dimension. Each
/// dimension sums its 10 items (range 10–50).
///
/// Throws [ArgumentError] if any item is missing or any response is out of the
/// 1–5 range — callers must only score a fully-answered test.
EqResult scoreEq(
  Map<int, int> answers, {
  List<EqItem> items = kEqItems,
  DateTime? completedAt,
}) {
  final Map<EqDimension, int> sums = <EqDimension, int>{
    for (final EqDimension d in EqDimension.values) d: 0,
  };

  for (final EqItem item in items) {
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
    final int scored =
        item.reverseScored ? (kLikertMax + kLikertMin) - response : response;
    sums[item.dimension] = sums[item.dimension]! + scored;
  }

  return EqResult(
    completedAt: completedAt ?? DateTime.now(),
    scores: sums,
  );
}
