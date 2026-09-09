import '../data/love_items.dart';
import '../data/models/love.dart';
import 'scoring.dart' show kLikertMin, kLikertMax;

/// Scores a completed set of Love Language answers.
///
/// [answers] maps a [LoveItem.id] (1–25) to the raw agreement response (1–5).
/// Items are all positively keyed, so each language's raw score is the sum of
/// its 5 responses (range 5–25).
LoveResult scoreLove(
  Map<int, int> answers, {
  List<LoveItem> items = kLoveItems,
  DateTime? completedAt,
}) {
  final Map<LoveLanguage, int> sums = <LoveLanguage, int>{
    for (final LoveLanguage l in LoveLanguage.values) l: 0,
  };

  for (final LoveItem item in items) {
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
    sums[item.language] = sums[item.language]! + response;
  }

  return LoveResult(completedAt: completedAt ?? DateTime.now(), scores: sums);
}
