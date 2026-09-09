import '../../l10n/app_localizations.dart';

/// The six vocational-interest areas of Holland's RIASEC model, as
/// operationalised by the O*NET Interest Profiler (U.S. Dept. of Labor).
///
/// Order follows the canonical R-I-A-S-E-C sequence — this is also the
/// tie-break order when two areas score equally (see [CareerResult.ranked]).
enum RiasecArea {
  realistic,
  investigative,
  artistic,
  social,
  enterprising,
  conventional;

  /// Stable string key used for persistence (do not translate/rename — it is
  /// written to shared_preferences).
  String get key => name;

  /// Single-letter Holland code marker ('R', 'I', 'A', 'S', 'E', 'C').
  String get letter => name[0].toUpperCase();

  /// Localised display name for the interest area.
  String label(AppLocalizations l10n) {
    switch (this) {
      case RiasecArea.realistic:
        return l10n.riasecRealistic;
      case RiasecArea.investigative:
        return l10n.riasecInvestigative;
      case RiasecArea.artistic:
        return l10n.riasecArtistic;
      case RiasecArea.social:
        return l10n.riasecSocial;
      case RiasecArea.enterprising:
        return l10n.riasecEnterprising;
      case RiasecArea.conventional:
        return l10n.riasecConventional;
    }
  }

  static RiasecArea fromKey(String key) =>
      RiasecArea.values.firstWhere((RiasecArea a) => a.key == key);
}

/// Fixed raw-score range for a RIASEC area: 8 items × 1–5 → 8–40.
abstract final class CareerBands {
  /// Minimum possible raw score for an area (8 items × 1).
  static const int minRaw = 8;

  /// Maximum possible raw score for an area (8 items × 5).
  static const int maxRaw = 40;
}

/// A completed Career Aptitude test: one raw sum (8–40) per [RiasecArea].
class CareerResult {
  const CareerResult({required this.scores, required this.completedAt});

  final Map<RiasecArea, int> scores;
  final DateTime completedAt;

  int operator [](RiasecArea area) => scores[area]!;

  /// Bar-fill fraction for [area], 0.2–1.0 (`raw / 40`).
  double fractionFor(RiasecArea area) => scores[area]! / CareerBands.maxRaw;

  /// [fractionFor] as a rounded whole percentage (20–100).
  int percentFor(RiasecArea area) => (fractionFor(area) * 100).round();

  /// Areas ordered strongest-first. Ties break by canonical enum order so the
  /// Holland code is deterministic.
  List<RiasecArea> get ranked {
    final List<RiasecArea> areas = List<RiasecArea>.of(RiasecArea.values);
    areas.sort((RiasecArea a, RiasecArea b) {
      final int byScore = scores[b]!.compareTo(scores[a]!);
      if (byScore != 0) return byScore;
      return a.index.compareTo(b.index);
    });
    return areas;
  }

  /// The three-letter Holland Code from the top-three areas (e.g. "SAE").
  String get hollandCode =>
      ranked.take(3).map((RiasecArea a) => a.letter).join();

  /// Serialise to a JSON-compatible map for local caching.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'completedAt': completedAt.toIso8601String(),
        'scores': <String, int>{
          for (final MapEntry<RiasecArea, int> e in scores.entries)
            e.key.key: e.value,
        },
      };

  factory CareerResult.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> rawScores =
        (json['scores'] as Map).cast<String, dynamic>();
    return CareerResult(
      completedAt: DateTime.parse(json['completedAt'] as String),
      scores: <RiasecArea, int>{
        for (final MapEntry<String, dynamic> e in rawScores.entries)
          RiasecArea.fromKey(e.key): e.value as int,
      },
    );
  }
}
