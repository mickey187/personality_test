import '../../l10n/app_localizations.dart';

/// The five love languages (Gary Chapman). A popular self-insight framework —
/// not an empirically validated construct — for how people prefer to give and
/// receive affection.
enum LoveLanguage {
  wordsOfAffirmation,
  qualityTime,
  receivingGifts,
  actsOfService,
  physicalTouch;

  /// Stable string key used for persistence (do not translate/rename).
  String get key => name;

  /// Localised display name for the love language.
  String label(AppLocalizations l10n) {
    switch (this) {
      case LoveLanguage.wordsOfAffirmation:
        return l10n.loveWordsOfAffirmation;
      case LoveLanguage.qualityTime:
        return l10n.loveQualityTime;
      case LoveLanguage.receivingGifts:
        return l10n.loveReceivingGifts;
      case LoveLanguage.actsOfService:
        return l10n.loveActsOfService;
      case LoveLanguage.physicalTouch:
        return l10n.lovePhysicalTouch;
    }
  }

  static LoveLanguage fromKey(String key) =>
      LoveLanguage.values.firstWhere((LoveLanguage l) => l.key == key);
}

/// Fixed raw-score range for a love language: 5 items × 1–5 → 5–25.
abstract final class LoveBands {
  static const int minRaw = 5;
  static const int maxRaw = 25;
}

/// A completed Love Language test: one raw sum (5–25) per [LoveLanguage].
class LoveResult {
  const LoveResult({required this.scores, required this.completedAt});

  final Map<LoveLanguage, int> scores;
  final DateTime completedAt;

  int operator [](LoveLanguage lang) => scores[lang]!;

  double fractionFor(LoveLanguage lang) => scores[lang]! / LoveBands.maxRaw;
  int percentFor(LoveLanguage lang) => (fractionFor(lang) * 100).round();

  /// Languages ordered strongest-first (ties break by canonical enum order).
  List<LoveLanguage> get ranked {
    final List<LoveLanguage> langs = List<LoveLanguage>.of(LoveLanguage.values);
    langs.sort((LoveLanguage a, LoveLanguage b) {
      final int byScore = scores[b]!.compareTo(scores[a]!);
      if (byScore != 0) return byScore;
      return a.index.compareTo(b.index);
    });
    return langs;
  }

  /// The user's primary love language.
  LoveLanguage get primary => ranked.first;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'completedAt': completedAt.toIso8601String(),
        'scores': <String, int>{
          for (final MapEntry<LoveLanguage, int> e in scores.entries)
            e.key.key: e.value,
        },
      };

  factory LoveResult.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> rawScores =
        (json['scores'] as Map).cast<String, dynamic>();
    return LoveResult(
      completedAt: DateTime.parse(json['completedAt'] as String),
      scores: <LoveLanguage, int>{
        for (final MapEntry<String, dynamic> e in rawScores.entries)
          LoveLanguage.fromKey(e.key): e.value as int,
      },
    );
  }
}
