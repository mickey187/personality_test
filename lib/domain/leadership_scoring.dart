import '../data/leadership_items.dart';
import '../data/models/leadership.dart';
import 'scoring.dart' show kLikertMin, kLikertMax;

/// Scores a completed set of Leadership Style answers.
///
/// [answers] maps a [LeadershipItem.id] (1–36) to the raw agreement response
/// (1–5). Items are all positively keyed, so each style's raw score is the sum
/// of its 6 responses (range 6–30).
LeadershipResult scoreLeadership(
  Map<int, int> answers, {
  List<LeadershipItem> items = kLeadershipItems,
  DateTime? completedAt,
}) {
  final Map<LeadershipStyle, int> sums = <LeadershipStyle, int>{
    for (final LeadershipStyle s in LeadershipStyle.values) s: 0,
  };

  for (final LeadershipItem item in items) {
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

  return LeadershipResult(
    completedAt: completedAt ?? DateTime.now(),
    scores: sums,
  );
}
