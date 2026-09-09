import '../../l10n/app_localizations.dart';

/// The four dimensions of emotional intelligence in the Wong & Law (WLEIS)
/// model, which operationalises the Mayer–Salovey four-branch ability model as
/// a self-report measure.
enum EqDimension {
  /// Self-Emotion Appraisal — understanding your own emotions.
  selfAppraisal,

  /// Others' Emotion Appraisal — reading the emotions of others.
  othersAppraisal,

  /// Use of Emotion — harnessing emotions to motivate and perform.
  useOfEmotion,

  /// Regulation of Emotion — managing and steadying your emotions.
  regulation;

  /// Stable string key used for persistence (do not translate/rename — it is
  /// written to shared_preferences).
  String get key => name;

  /// Localised display name for the dimension.
  String label(AppLocalizations l10n) {
    switch (this) {
      case EqDimension.selfAppraisal:
        return l10n.eqSelfAppraisal;
      case EqDimension.othersAppraisal:
        return l10n.eqOthersAppraisal;
      case EqDimension.useOfEmotion:
        return l10n.eqUseOfEmotion;
      case EqDimension.regulation:
        return l10n.eqRegulation;
    }
  }

  static EqDimension fromKey(String key) =>
      EqDimension.values.firstWhere((EqDimension d) => d.key == key);
}

/// Band an EQ score falls into. Drives which description the user sees.
enum EqLevel {
  low,
  mid,
  high;

  String get key => name;

  static EqLevel fromKey(String key) =>
      EqLevel.values.firstWhere((EqLevel l) => l.key == key);
}

/// Fixed score bands for the EQ test (10 items per dimension, 5-point Likert).
///
/// Transparent thirds of the item-mean rather than population norms (there is
/// no backend / norm sample yet). Change here to retune later.
abstract final class EqBands {
  /// Minimum possible raw score for a dimension (10 items × 1).
  static const int minRaw = 10;

  /// Maximum possible raw score for a dimension (10 items × 5).
  static const int maxRaw = 50;

  /// Highest per-dimension raw still considered [EqLevel.low]  (mean ≤ 2.2).
  static const int lowCeiling = 22;

  /// Highest per-dimension raw still considered [EqLevel.mid]  (mean ≤ 3.5).
  static const int midCeiling = 35;

  /// Minimum possible overall score (40 items × 1).
  static const int overallMin = 40;

  /// Maximum possible overall score (40 items × 5).
  static const int overallMax = 200;

  /// Highest overall raw still considered [EqLevel.low]  (mean ≤ 2.2).
  static const int overallLowCeiling = 88;

  /// Highest overall raw still considered [EqLevel.mid]  (mean ≤ 3.5).
  static const int overallMidCeiling = 140;

  static EqLevel levelFor(int raw) {
    if (raw <= lowCeiling) return EqLevel.low;
    if (raw <= midCeiling) return EqLevel.mid;
    return EqLevel.high;
  }

  static EqLevel overallLevelFor(int raw) {
    if (raw <= overallLowCeiling) return EqLevel.low;
    if (raw <= overallMidCeiling) return EqLevel.mid;
    return EqLevel.high;
  }
}

/// A completed EQ test: one raw sum (10–50) per [EqDimension].
class EqResult {
  const EqResult({required this.scores, required this.completedAt});

  final Map<EqDimension, int> scores;
  final DateTime completedAt;

  int operator [](EqDimension dim) => scores[dim]!;

  /// Total across all four dimensions (40–200).
  int get overall => scores.values.fold(0, (int sum, int v) => sum + v);

  /// Overall EQ band.
  EqLevel get overallLevel => EqBands.overallLevelFor(overall);

  /// Overall EQ as a rounded whole percentage (20–100).
  int get overallPercent =>
      ((overall / EqBands.overallMax) * 100).round();

  /// Bar-fill fraction for [dim], 0.2–1.0 (`raw / 50`).
  double fractionFor(EqDimension dim) => scores[dim]! / EqBands.maxRaw;

  /// [fractionFor] as a rounded whole percentage (20–100).
  int percentFor(EqDimension dim) => (fractionFor(dim) * 100).round();

  /// Band for a single dimension.
  EqLevel levelFor(EqDimension dim) => EqBands.levelFor(scores[dim]!);

  /// Dimensions ordered strongest-first. Ties break by canonical enum order.
  List<EqDimension> get ranked {
    final List<EqDimension> dims = List<EqDimension>.of(EqDimension.values);
    dims.sort((EqDimension a, EqDimension b) {
      final int byScore = scores[b]!.compareTo(scores[a]!);
      if (byScore != 0) return byScore;
      return a.index.compareTo(b.index);
    });
    return dims;
  }

  /// Serialise to a JSON-compatible map for local caching.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'completedAt': completedAt.toIso8601String(),
        'scores': <String, int>{
          for (final MapEntry<EqDimension, int> e in scores.entries)
            e.key.key: e.value,
        },
      };

  factory EqResult.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> rawScores =
        (json['scores'] as Map).cast<String, dynamic>();
    return EqResult(
      completedAt: DateTime.parse(json['completedAt'] as String),
      scores: <EqDimension, int>{
        for (final MapEntry<String, dynamic> e in rawScores.entries)
          EqDimension.fromKey(e.key): e.value as int,
      },
    );
  }
}
