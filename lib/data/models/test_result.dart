import 'trait.dart';

/// Fixed score bands for the Mini-IPIP raw trait score (4–20).
///
/// v1 uses simple, transparent thirds rather than population norms (there is no
/// backend / user base yet). Change these in ONE place to retune later.
///
///   low : 4–9   mid : 10–14   high : 15–20
abstract final class ScoreBands {
  /// Minimum possible raw score for a trait (4 items × 1).
  static const int minRaw = 4;

  /// Maximum possible raw score for a trait (4 items × 5).
  static const int maxRaw = 20;

  /// Highest raw score still considered [TraitLevel.low].
  static const int lowCeiling = 9;

  /// Highest raw score still considered [TraitLevel.mid].
  static const int midCeiling = 14;

  static TraitLevel levelFor(int raw) {
    if (raw <= lowCeiling) return TraitLevel.low;
    if (raw <= midCeiling) return TraitLevel.mid;
    return TraitLevel.high;
  }
}

/// The scored result for a single trait.
class TraitScore {
  const TraitScore({required this.trait, required this.raw})
    : assert(raw >= ScoreBands.minRaw && raw <= ScoreBands.maxRaw,
          'raw score out of range');

  final Trait trait;

  /// Sum of the four (reverse-adjusted) item responses, 4–20.
  final int raw;

  /// Which band the raw score falls into.
  TraitLevel get level => ScoreBands.levelFor(raw);

  /// Mean item response, 1.0–5.0.
  double get average => raw / 4.0;

  /// Position within the 4–20 range, 0.0–1.0 (handy for a radar plot where the
  /// axis should start at the true minimum).
  double get normalized =>
      (raw - ScoreBands.minRaw) / (ScoreBands.maxRaw - ScoreBands.minRaw);

  /// Bar-fill fraction shown in the UI, 0.2–1.0 — this is `average / 5`
  /// (equivalently `raw / 20`), matching the design's percentage bars.
  double get fraction => raw / ScoreBands.maxRaw;

  /// [fraction] as a rounded whole percentage (20–100).
  int get percent => (fraction * 100).round();
}

/// A completed test: one [TraitScore] per Big Five trait.
class TestResult {
  const TestResult({required this.scores, required this.completedAt});

  final Map<Trait, TraitScore> scores;
  final DateTime completedAt;

  TraitScore operator [](Trait trait) => scores[trait]!;

  /// Serialise to a JSON-compatible map for local caching.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'completedAt': completedAt.toIso8601String(),
        'scores': <String, int>{
          for (final MapEntry<Trait, TraitScore> e in scores.entries)
            e.key.key: e.value.raw,
        },
      };

  factory TestResult.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> rawScores =
        (json['scores'] as Map).cast<String, dynamic>();
    return TestResult(
      completedAt: DateTime.parse(json['completedAt'] as String),
      scores: <Trait, TraitScore>{
        for (final MapEntry<String, dynamic> e in rawScores.entries)
          Trait.fromKey(e.key): TraitScore(
            trait: Trait.fromKey(e.key),
            raw: e.value as int,
          ),
      },
    );
  }
}
