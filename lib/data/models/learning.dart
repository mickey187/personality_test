import '../../l10n/app_localizations.dart';

/// The four modes of the VARK learning-preferences model (Neil Fleming):
/// Visual, Auditory, Reading/Writing, Kinesthetic. A popular self-insight model
/// of study preferences — not a validated predictor of learning outcomes.
enum LearningStyle {
  visual,
  auditory,
  readingWriting,
  kinesthetic;

  /// Stable string key used for persistence (do not translate/rename).
  String get key => name;

  String label(AppLocalizations l10n) {
    switch (this) {
      case LearningStyle.visual:
        return l10n.learningVisual;
      case LearningStyle.auditory:
        return l10n.learningAuditory;
      case LearningStyle.readingWriting:
        return l10n.learningReadingWriting;
      case LearningStyle.kinesthetic:
        return l10n.learningKinesthetic;
    }
  }

  static LearningStyle fromKey(String key) =>
      LearningStyle.values.firstWhere((LearningStyle s) => s.key == key);
}

/// Fixed raw-score range for a mode: 5 items × 1–5 → 5–25.
abstract final class LearningBands {
  static const int minRaw = 5;
  static const int maxRaw = 25;
}

/// A completed Learning Style test: one raw sum (5–25) per [LearningStyle].
class LearningResult {
  const LearningResult({required this.scores, required this.completedAt});

  final Map<LearningStyle, int> scores;
  final DateTime completedAt;

  int operator [](LearningStyle style) => scores[style]!;

  double fractionFor(LearningStyle style) =>
      scores[style]! / LearningBands.maxRaw;
  int percentFor(LearningStyle style) => (fractionFor(style) * 100).round();

  List<LearningStyle> get ranked {
    final List<LearningStyle> styles =
        List<LearningStyle>.of(LearningStyle.values);
    styles.sort((LearningStyle a, LearningStyle b) {
      final int byScore = scores[b]!.compareTo(scores[a]!);
      if (byScore != 0) return byScore;
      return a.index.compareTo(b.index);
    });
    return styles;
  }

  /// The user's primary learning mode.
  LearningStyle get primary => ranked.first;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'completedAt': completedAt.toIso8601String(),
        'scores': <String, int>{
          for (final MapEntry<LearningStyle, int> e in scores.entries)
            e.key.key: e.value,
        },
      };

  factory LearningResult.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> rawScores =
        (json['scores'] as Map).cast<String, dynamic>();
    return LearningResult(
      completedAt: DateTime.parse(json['completedAt'] as String),
      scores: <LearningStyle, int>{
        for (final MapEntry<String, dynamic> e in rawScores.entries)
          LearningStyle.fromKey(e.key): e.value as int,
      },
    );
  }
}
