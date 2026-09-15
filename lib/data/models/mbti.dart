/// The four preference pairs from Jungian personality-type theory (public
/// domain psychological concepts, not the trademarked MBTI® instrument).
enum MbtiAxis { ei, sn, tf, jp }

/// The eight poles across the four [MbtiAxis] pairs.
enum MbtiPole {
  e, i,
  s, n,
  t, f,
  j, p;

  /// Which axis this pole belongs to.
  MbtiAxis get axis => switch (this) {
        MbtiPole.e || MbtiPole.i => MbtiAxis.ei,
        MbtiPole.s || MbtiPole.n => MbtiAxis.sn,
        MbtiPole.t || MbtiPole.f => MbtiAxis.tf,
        MbtiPole.j || MbtiPole.p => MbtiAxis.jp,
      };

  /// The letter shown in the 4-letter type code.
  String get letter => name.toUpperCase();

  /// Stable string key used for persistence (do not translate/rename — it is
  /// written to shared_preferences).
  String get key => name;

  static MbtiPole fromKey(String key) =>
      MbtiPole.values.firstWhere((MbtiPole p) => p.key == key);
}

/// A completed personality-type test: a raw sum per [MbtiPole].
class MbtiResult {
  const MbtiResult({
    required this.completedAt,
    required this.poleScores,
    required this.poleCounts,
  });

  final DateTime completedAt;

  /// Raw sum for every pole (not just the winner) — needed to render a
  /// strength bar per axis.
  final Map<MbtiPole, int> poleScores;

  /// Number of items measuring each pole in the presented item set, used to
  /// normalise raw sums into comparable per-item means. Poles within an axis
  /// may have an uneven item count (e.g. 4 vs 3), so a winner must be decided
  /// by mean, not raw sum.
  final Map<MbtiPole, int> poleCounts;

  double _meanFor(MbtiPole pole) => poleScores[pole]! / poleCounts[pole]!;

  /// The winning pole for [axis]. Ties resolve to the canonical first pole
  /// (E, S, T, J) — a deterministic, documented tie-break rather than an
  /// arbitrary one, since dichotomy means often land close to their midpoint.
  MbtiPole winnerFor(MbtiAxis axis) {
    final (MbtiPole first, MbtiPole second) = _polesOf(axis);
    return _meanFor(second) > _meanFor(first) ? second : first;
  }

  /// 4-letter type code, axis order ei-sn-tf-jp, e.g. "INTJ".
  String get typeCode =>
      MbtiAxis.values.map((MbtiAxis a) => winnerFor(a).letter).join();

  /// Strength of the winning pole within [axis], 0.5-1.0
  /// (`winningMean / (winningMean + losingMean)`).
  double strengthFor(MbtiAxis axis) {
    final (MbtiPole first, MbtiPole second) = _polesOf(axis);
    final MbtiPole winner = winnerFor(axis);
    final MbtiPole loser = winner == first ? second : first;
    final double winMean = _meanFor(winner);
    final double loseMean = _meanFor(loser);
    return winMean / (winMean + loseMean);
  }

  /// [strengthFor] as a rounded whole percentage (50-100).
  int strengthPercentFor(MbtiAxis axis) => (strengthFor(axis) * 100).round();

  static (MbtiPole, MbtiPole) _polesOf(MbtiAxis axis) => switch (axis) {
        MbtiAxis.ei => (MbtiPole.e, MbtiPole.i),
        MbtiAxis.sn => (MbtiPole.s, MbtiPole.n),
        MbtiAxis.tf => (MbtiPole.t, MbtiPole.f),
        MbtiAxis.jp => (MbtiPole.j, MbtiPole.p),
      };

  /// Serialise to a JSON-compatible map for local caching.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'completedAt': completedAt.toIso8601String(),
        'poleScores': <String, int>{
          for (final MapEntry<MbtiPole, int> e in poleScores.entries)
            e.key.key: e.value,
        },
        'poleCounts': <String, int>{
          for (final MapEntry<MbtiPole, int> e in poleCounts.entries)
            e.key.key: e.value,
        },
      };

  factory MbtiResult.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> rawScores =
        (json['poleScores'] as Map).cast<String, dynamic>();
    final Map<String, dynamic> rawCounts =
        (json['poleCounts'] as Map).cast<String, dynamic>();
    return MbtiResult(
      completedAt: DateTime.parse(json['completedAt'] as String),
      poleScores: <MbtiPole, int>{
        for (final MapEntry<String, dynamic> e in rawScores.entries)
          MbtiPole.fromKey(e.key): e.value as int,
      },
      poleCounts: <MbtiPole, int>{
        for (final MapEntry<String, dynamic> e in rawCounts.entries)
          MbtiPole.fromKey(e.key): e.value as int,
      },
    );
  }
}
