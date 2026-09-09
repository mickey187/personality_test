import '../../l10n/app_localizations.dart';

/// The six leadership styles identified by Daniel Goleman ("Leadership That
/// Gets Results", HBR 2000). A self-report profile of the styles you lean on.
enum LeadershipStyle {
  visionary,
  coaching,
  affiliative,
  democratic,
  pacesetting,
  commanding;

  /// Stable string key used for persistence (do not translate/rename).
  String get key => name;

  String label(AppLocalizations l10n) {
    switch (this) {
      case LeadershipStyle.visionary:
        return l10n.leadershipVisionary;
      case LeadershipStyle.coaching:
        return l10n.leadershipCoaching;
      case LeadershipStyle.affiliative:
        return l10n.leadershipAffiliative;
      case LeadershipStyle.democratic:
        return l10n.leadershipDemocratic;
      case LeadershipStyle.pacesetting:
        return l10n.leadershipPacesetting;
      case LeadershipStyle.commanding:
        return l10n.leadershipCommanding;
    }
  }

  static LeadershipStyle fromKey(String key) =>
      LeadershipStyle.values.firstWhere((LeadershipStyle s) => s.key == key);
}

/// Fixed raw-score range for a style: 6 items × 1–5 → 6–30.
abstract final class LeadershipBands {
  static const int minRaw = 6;
  static const int maxRaw = 30;
}

/// A completed Leadership Style test: one raw sum (6–30) per [LeadershipStyle].
class LeadershipResult {
  const LeadershipResult({required this.scores, required this.completedAt});

  final Map<LeadershipStyle, int> scores;
  final DateTime completedAt;

  int operator [](LeadershipStyle style) => scores[style]!;

  double fractionFor(LeadershipStyle style) =>
      scores[style]! / LeadershipBands.maxRaw;
  int percentFor(LeadershipStyle style) => (fractionFor(style) * 100).round();

  List<LeadershipStyle> get ranked {
    final List<LeadershipStyle> styles =
        List<LeadershipStyle>.of(LeadershipStyle.values);
    styles.sort((LeadershipStyle a, LeadershipStyle b) {
      final int byScore = scores[b]!.compareTo(scores[a]!);
      if (byScore != 0) return byScore;
      return a.index.compareTo(b.index);
    });
    return styles;
  }

  /// The user's dominant leadership style.
  LeadershipStyle get dominant => ranked.first;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'completedAt': completedAt.toIso8601String(),
        'scores': <String, int>{
          for (final MapEntry<LeadershipStyle, int> e in scores.entries)
            e.key.key: e.value,
        },
      };

  factory LeadershipResult.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> rawScores =
        (json['scores'] as Map).cast<String, dynamic>();
    return LeadershipResult(
      completedAt: DateTime.parse(json['completedAt'] as String),
      scores: <LeadershipStyle, int>{
        for (final MapEntry<String, dynamic> e in rawScores.entries)
          LeadershipStyle.fromKey(e.key): e.value as int,
      },
    );
  }
}
