import 'trait.dart';

/// A localized string with the language variants v1 ships.
///
/// Test items and trait descriptions are structured domain content (not UI
/// chrome), so they live in Dart data files rather than ARB. Resolve with
/// [resolve] using the active locale's language code.
class LocalizedText {
  const LocalizedText({required this.en, required this.am});

  final String en;
  final String am;

  /// Returns the variant for [languageCode] ('am' for Amharic), defaulting to
  /// English for any other/unknown code.
  String resolve(String languageCode) => languageCode == 'am' ? am : en;
}

/// A single Mini-IPIP item.
class Question {
  const Question({
    required this.id,
    required this.trait,
    required this.reverseScored,
    required this.text,
  });

  /// 1-based item number in canonical Mini-IPIP order.
  final int id;

  /// Which Big Five trait this item loads onto.
  final Trait trait;

  /// Whether the item is negatively keyed. Reverse-scored items are flipped
  /// (6 − response) during scoring — the wording is left negative on purpose,
  /// so do NOT "un-negate" the translation.
  final bool reverseScored;

  /// First-person statement shown to the user, in each supported language.
  final LocalizedText text;
}
