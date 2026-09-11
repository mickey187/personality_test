import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/eq.dart';
import '../../data/models/leadership.dart';
import '../../data/models/learning.dart';
import '../../data/models/love.dart';
import '../../data/models/riasec.dart';
import '../../data/models/trait.dart';

/// Design-system tokens for the "premium self-discovery" redesign: a calm
/// off-white canvas, white cards, and one indigo/blue app-wide accent, with
/// each assessment carrying its own accent (see [AppAccents]) used for its
/// icon, hero and progress states.
abstract final class AppColors {
  /// App canvas.
  static const Color bg = Color(0xFFFAF9F5);

  /// Card / surface fill.
  static const Color surface = Color(0xFFFFFFFF);

  /// Primary ink.
  static const Color text = Color(0xFF172033);

  /// Hairline borders between surface and canvas.
  static const Color border = Color(0xFFE8E6DF);

  /// App-wide indigo/blue accent (buttons, links, the Personality assessment).
  static const Color accent = Color(0xFF4F63D6);

  /// Secondary decorative accent (brand-mark gradient only).
  static const Color accent2 = Color(0xFF14A89A);

  // Accent ramp steps.
  static const Color accentTint = Color(0xFFEEF0FC);
  static const Color accentLight = Color(0xFF8B97E8);
  static const Color accentHover = Color(0xFF3E4FBE);
  static const Color accentActive = Color(0xFF2F3E9E);

  /// Secondary text — labels, meta, chrome (`--color-secondary`).
  static const Color muted = Color(0xFF687080);

  /// Body copy — a touch darker than [muted] for comfortable reading.
  static const Color bodyMuted = Color(0xFF4B5468);

  /// Near-black used only for the dark share-card gradient.
  static const Color inkSoft = Color(0xFF14172A);

  /// Muted text tuned for the dark share-card gradient — [muted]/[bodyMuted]
  /// are calibrated for light surfaces and read too low-contrast on dark.
  static const Color onDarkMuted = Color(0xFFA6ACC4);

  /// `--color-divider`.
  static Color get divider => text.withValues(alpha: 0.10);
}

/// One accent colour per assessment — used for its home card icon, intro
/// hero, question-screen progress/selection state, and results hero. Keeps
/// six tests reading as one system (shared radii/type/surfaces) while each
/// still has a distinct identity, per the brief's "assessment accents" table.
abstract final class AppAccents {
  static const Color personality = AppColors.accent; // indigo/blue
  static const Color career = Color(0xFF2F9E6E); // green
  static const Color eq = Color(0xFFE8734A); // orange/coral
  static const Color leadership = Color(0xFF7C5CD9); // purple
  static const Color learning = Color(0xFF14A89A); // teal
  static const Color love = Color(0xFFE15B84); // rose
}

/// Curated dimension palette shared by every per-trait/per-area colour map
/// below, so bars across different tests still read as one design system.
abstract final class _Palette {
  static const Color indigo = Color(0xFF4F63D6);
  static const Color green = Color(0xFF2F9E6E);
  static const Color coral = Color(0xFFE8734A);
  static const Color purple = Color(0xFF7C5CD9);
  static const Color teal = Color(0xFF14A89A);
  static const Color rose = Color(0xFFE15B84);
  static const Color amber = Color(0xFFE0A83E);
}

/// Trait accent colours for the Big Five results screen.
const Map<Trait, Color> kTraitColors = <Trait, Color>{
  Trait.extraversion: _Palette.green,
  Trait.agreeableness: _Palette.coral,
  Trait.conscientiousness: _Palette.indigo,
  Trait.neuroticism: _Palette.purple,
  Trait.openness: _Palette.teal,
};

/// Accent colours for the six RIASEC interest areas on the Career results.
const Map<RiasecArea, Color> kRiasecColors = <RiasecArea, Color>{
  RiasecArea.realistic: _Palette.green,
  RiasecArea.investigative: _Palette.indigo,
  RiasecArea.artistic: _Palette.rose,
  RiasecArea.social: _Palette.amber,
  RiasecArea.enterprising: _Palette.purple,
  RiasecArea.conventional: _Palette.teal,
};

/// Accent colours for the four EQ dimensions on the results screen.
const Map<EqDimension, Color> kEqColors = <EqDimension, Color>{
  EqDimension.selfAppraisal: _Palette.coral,
  EqDimension.othersAppraisal: _Palette.green,
  EqDimension.useOfEmotion: _Palette.amber,
  EqDimension.regulation: _Palette.indigo,
};

/// Accent colours for the five love languages on the results screen.
const Map<LoveLanguage, Color> kLoveColors = <LoveLanguage, Color>{
  LoveLanguage.wordsOfAffirmation: _Palette.rose,
  LoveLanguage.qualityTime: _Palette.indigo,
  LoveLanguage.receivingGifts: _Palette.amber,
  LoveLanguage.actsOfService: _Palette.green,
  LoveLanguage.physicalTouch: _Palette.purple,
};

/// Accent colours for the six Goleman leadership styles.
const Map<LeadershipStyle, Color> kLeadershipColors = <LeadershipStyle, Color>{
  LeadershipStyle.visionary: _Palette.purple,
  LeadershipStyle.coaching: _Palette.green,
  LeadershipStyle.affiliative: _Palette.rose,
  LeadershipStyle.democratic: _Palette.indigo,
  LeadershipStyle.pacesetting: _Palette.amber,
  LeadershipStyle.commanding: _Palette.coral,
};

/// Accent colours for the four VARK learning modes.
const Map<LearningStyle, Color> kLearningColors = <LearningStyle, Color>{
  LearningStyle.visual: _Palette.teal,
  LearningStyle.auditory: _Palette.amber,
  LearningStyle.readingWriting: _Palette.green,
  LearningStyle.kinesthetic: _Palette.indigo,
};

/// Corner-radius hierarchy. Only [pill] is a true stadium shape — badges,
/// chips and toggles; everything else gets a fixed radius so the UI reads as
/// deliberate rather than "everything is equally soft."
abstract final class AppRadii {
  static const double sm = 8;

  /// Inner cards (trait/insight cards nested inside a screen).
  static const double md = 16;

  /// Buttons — a rounded rect, not a stadium.
  static const double button = 14;

  /// Hero / outer cards.
  static const double lg = 24;

  /// Badges, chips, toggles.
  static const double pill = 999;
}

/// Brand + fixed strings that are the same in every language.
abstract final class Brand {
  /// The app name, always shown in Amharic script ("Who Am I?").
  static const String nameAm = 'እኔ ማነኝ';

  /// English brand subtitle under the mark.
  static const String tagline = 'Who Am I?';

  static const String profileLabel = 'Big Five Profile';

  /// Store CTA printed on the share card / used in share text.
  static const String storeUrl = 'play.google.com/store/apps/enemanej';

  static const String citation =
      'Mini-IPIP · Donnellan, Oswald, Baird & Lucas (2006)\n'
      'Big Five / IPIP · Public Domain';
}

/// Typography helpers.
///
/// Sora (display) and Inter (body) carry no Geʽez glyphs, so every style
/// lists Noto Sans Ethiopic as a fallback — Amharic still renders correctly
/// on Latin-primary styles.
abstract final class AppFonts {
  static final String _ethiopic = GoogleFonts.notoSansEthiopic().fontFamily!;

  /// Display / heading style (Sora) with Ethiopic fallback.
  static TextStyle display({
    required double size,
    Color color = AppColors.text,
    FontWeight weight = FontWeight.w700,
    double? height,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sora(
        fontSize: size,
        color: color,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
      ).copyWith(fontFamilyFallback: <String>[_ethiopic]);

  /// Body style (Inter) with Ethiopic fallback.
  static TextStyle body({
    required double size,
    Color color = AppColors.text,
    FontWeight weight = FontWeight.w400,
    double? height,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        color: color,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
      ).copyWith(fontFamilyFallback: <String>[_ethiopic]);

  /// Native Amharic style (Noto Sans Ethiopic) for Geʽez-first headings.
  static TextStyle ethiopic({
    required double size,
    Color color = AppColors.text,
    FontWeight weight = FontWeight.w700,
    double? height,
  }) =>
      GoogleFonts.notoSansEthiopic(
        fontSize: size,
        color: color,
        fontWeight: weight,
        height: height,
      );
}

/// Builds the app's light theme.
ThemeData buildOrganicTheme() {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: AppColors.accent,
    brightness: Brightness.light,
    surface: AppColors.bg,
  ).copyWith(
    primary: AppColors.accent,
    secondary: AppColors.accent2,
    onPrimary: AppColors.surface,
    surface: AppColors.bg,
    onSurface: AppColors.text,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.bg,
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
      fontFamilyFallback: <String>[GoogleFonts.notoSansEthiopic().fontFamily!],
    ),
    splashFactory: InkRipple.splashFactory,
  );
}
