import '../data/career_items.dart';
import '../data/models/riasec.dart';
import 'scoring.dart' show kLikertMin, kLikertMax;

/// Scores a completed set of Career Aptitude (RIASEC) answers.
///
/// [answers] maps a [CareerItem.id] (1–48) to the raw like/dislike response
/// (1 = strongly dislike, 5 = strongly like). Items are all positively keyed,
/// so each area's raw score is simply the sum of its 8 responses (range 8–40).
///
/// Throws [ArgumentError] if any item is missing or any response is out of the
/// 1–5 range — callers must only score a fully-answered test.
CareerResult scoreCareer(
  Map<int, int> answers, {
  List<CareerItem> items = kCareerItems,
  DateTime? completedAt,
}) {
  final Map<RiasecArea, int> sums = <RiasecArea, int>{
    for (final RiasecArea a in RiasecArea.values) a: 0,
  };

  for (final CareerItem item in items) {
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
    sums[item.area] = sums[item.area]! + response;
  }

  return CareerResult(
    completedAt: completedAt ?? DateTime.now(),
    scores: sums,
  );
}
