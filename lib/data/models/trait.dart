import '../../l10n/app_localizations.dart';

/// The five factors measured by the Mini-IPIP (Big Five model).
///
/// Order follows the conventional Big Five presentation (OCEAN is a common
/// mnemonic, though we surface them in a reader-friendly order in the UI).
enum Trait {
  extraversion,
  agreeableness,
  conscientiousness,
  neuroticism,
  openness;

  /// Stable string key used for persistence (do not translate/rename — it is
  /// written to shared_preferences).
  String get key => name;

  /// Localised display name for the trait.
  String label(AppLocalizations l10n) {
    switch (this) {
      case Trait.extraversion:
        return l10n.traitExtraversion;
      case Trait.agreeableness:
        return l10n.traitAgreeableness;
      case Trait.conscientiousness:
        return l10n.traitConscientiousness;
      case Trait.neuroticism:
        return l10n.traitNeuroticism;
      case Trait.openness:
        return l10n.traitOpenness;
    }
  }

  static Trait fromKey(String key) =>
      Trait.values.firstWhere((Trait t) => t.key == key);
}

/// Band a raw trait score falls into. Drives which description the user sees.
///
/// v1 uses simple fixed thirds of the 4–20 raw range (see ScoreBands); this
/// is intentionally transparent and easy to retune once population norms exist.
enum TraitLevel {
  low,
  mid,
  high;

  String get key => name;

  static TraitLevel fromKey(String key) =>
      TraitLevel.values.firstWhere((TraitLevel l) => l.key == key);
}
