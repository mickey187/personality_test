import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/eq.dart';
import '../../data/models/leadership.dart';
import '../../data/models/learning.dart';
import '../../data/models/love.dart';
import '../../data/models/riasec.dart';
import '../../data/models/trait.dart';

/// Organic design-system tokens, ported from the Claude Design `_ds/styles.css`
/// and the "Personality Test" source. Colours are used directly (the design
/// hard-codes them per element) rather than only through [ColorScheme].
abstract final class AppColors {
  /// App canvas (`--color-bg`).
  static const Color bg = Color(0xFFF5EAD8);

  /// The device / outer page tone behind the app.
  static const Color deviceBg = Color(0xFFE8DECE);

  /// Card / control fill (`--color-surface`).
  static const Color surface = Color(0xFFEBDDC5);

  /// Primary ink (`--color-text`).
  static const Color text = Color(0xFF201E1D);

  /// Blue accent (`--color-accent`); swapped from the original terracotta,
  /// hue-rotated to blue while preserving each step's lightness/saturation.
  static const Color accent = Color(0xFF3982C6);

  /// Sage second accent (`--color-accent-2`).
  static const Color accent2 = Color(0xFF7A8A5E);

  // Accent ramp steps used by the design.
  static const Color accentTint = Color(0xFFEBF6FF); // accent-100
  static const Color accentLight = Color(0xFF6BB5F6); // accent-400
  static const Color accentHover = Color(0xFF2D72B2); // accent-600
  static const Color accentActive = Color(0xFF1A548C); // accent-700

  // Neutral ramp steps used by the design.
  static const Color muted = Color(0xFFA19786); // neutral-500 (labels)
  static const Color bodyMuted = Color(0xFF645C50); // neutral-700 (body copy)
  static const Color inkSoft = Color(0xFF2E2B25); // neutral-900 (share card)

  /// `--color-divider` (16% ink).
  static Color get divider => text.withValues(alpha: 0.16);
}

/// Trait accent colours from the design's `TRAIT_COLORS`, retuned to the blue
/// palette alongside the accent swap (E→accent, N→accent-700 dark blue,
/// C→accent-400 light blue; A/O keep the sage second accent).
const Map<Trait, Color> kTraitColors = <Trait, Color>{
  Trait.extraversion: Color(0xFF3982C6),
  Trait.agreeableness: Color(0xFF7A8A5E),
  Trait.conscientiousness: Color(0xFF6BB5F6),
  Trait.neuroticism: Color(0xFF1A548C),
  Trait.openness: Color(0xFFAEBF92),
};

/// Accent colours for the six RIASEC interest areas on the Career Aptitude
/// results screen. Drawn from the app's warm blue/sage palette so the bars sit
/// comfortably alongside the rest of the design.
const Map<RiasecArea, Color> kRiasecColors = <RiasecArea, Color>{
  RiasecArea.realistic: Color(0xFF7A8A5E), // sage
  RiasecArea.investigative: Color(0xFF3982C6), // blue accent
  RiasecArea.artistic: Color(0xFFC65B8A), // rose
  RiasecArea.social: Color(0xFFE8A44A), // amber
  RiasecArea.enterprising: Color(0xFF1A548C), // dark blue
  RiasecArea.conventional: Color(0xFF6BB5F6), // light blue
};

/// Accent colours for the four EQ dimensions on the results screen, drawn from
/// the app's warm blue/sage palette.
const Map<EqDimension, Color> kEqColors = <EqDimension, Color>{
  EqDimension.selfAppraisal: Color(0xFF3982C6), // blue accent
  EqDimension.othersAppraisal: Color(0xFF7A8A5E), // sage
  EqDimension.useOfEmotion: Color(0xFFE8A44A), // amber
  EqDimension.regulation: Color(0xFF1A548C), // dark blue
};

/// Accent colours for the five love languages on the results screen.
const Map<LoveLanguage, Color> kLoveColors = <LoveLanguage, Color>{
  LoveLanguage.wordsOfAffirmation: Color(0xFF3982C6), // blue
  LoveLanguage.qualityTime: Color(0xFF7A8A5E), // sage
  LoveLanguage.receivingGifts: Color(0xFFE8A44A), // amber
  LoveLanguage.actsOfService: Color(0xFF1A548C), // dark blue
  LoveLanguage.physicalTouch: Color(0xFFC65B8A), // rose
};

/// Accent colours for the six Goleman leadership styles.
const Map<LeadershipStyle, Color> kLeadershipColors = <LeadershipStyle, Color>{
  LeadershipStyle.visionary: Color(0xFF3982C6), // blue
  LeadershipStyle.coaching: Color(0xFF7A8A5E), // sage
  LeadershipStyle.affiliative: Color(0xFFC65B8A), // rose
  LeadershipStyle.democratic: Color(0xFF6BB5F6), // light blue
  LeadershipStyle.pacesetting: Color(0xFFE8A44A), // amber
  LeadershipStyle.commanding: Color(0xFF1A548C), // dark blue
};

/// Accent colours for the four VARK learning modes.
const Map<LearningStyle, Color> kLearningColors = <LearningStyle, Color>{
  LearningStyle.visual: Color(0xFF3982C6), // blue
  LearningStyle.auditory: Color(0xFFE8A44A), // amber
  LearningStyle.readingWriting: Color(0xFF7A8A5E), // sage
  LearningStyle.kinesthetic: Color(0xFF1A548C), // dark blue
};

/// Corner radii (`--radius-*`); small controls go fully pill (999px).
abstract final class AppRadii {
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 28;
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
/// Caprasimo (display) and Figtree (body) carry no Geʽez glyphs, so every style
/// lists Noto Sans Ethiopic as a fallback — Amharic then renders correctly even
/// on Latin-primary styles, matching the browser fallback the design relied on.
abstract final class AppFonts {
  static final String _ethiopic = GoogleFonts.notoSansEthiopic().fontFamily!;

  /// Display / heading style (Caprasimo) with Ethiopic fallback.
  static TextStyle display({
    required double size,
    Color color = AppColors.text,
    double? height,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.caprasimo(
        fontSize: size,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      ).copyWith(fontFamilyFallback: <String>[_ethiopic]);

  /// Body style (Figtree) with Ethiopic fallback.
  static TextStyle body({
    required double size,
    Color color = AppColors.text,
    FontWeight weight = FontWeight.w400,
    double? height,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.figtree(
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

/// Builds the app's light Organic theme.
ThemeData buildOrganicTheme() {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: AppColors.accent,
    brightness: Brightness.light,
    surface: AppColors.bg,
  ).copyWith(
    primary: AppColors.accent,
    secondary: AppColors.accent2,
    onPrimary: AppColors.bg,
    surface: AppColors.bg,
    onSurface: AppColors.text,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.bg,
    textTheme: GoogleFonts.figtreeTextTheme().apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
      fontFamilyFallback: <String>[GoogleFonts.notoSansEthiopic().fontFamily!],
    ),
    splashFactory: InkRipple.splashFactory,
  );
}
