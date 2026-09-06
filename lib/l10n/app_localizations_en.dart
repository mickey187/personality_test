// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Who Am I?';

  @override
  String get landingDesc =>
      'Discover your personality — a science-based Big Five assessment in just 2 minutes.';

  @override
  String get landingTime => '~2 minutes';

  @override
  String get landingScience => 'Scientifically validated';

  @override
  String get startButton => 'Start Test';

  @override
  String get continueButton => 'Continue';

  @override
  String get aboutLink => 'About this test';

  @override
  String questionProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get likert1 => 'Very Inaccurate';

  @override
  String get likert2 => 'Slightly Inaccurate';

  @override
  String get likert3 => 'Neutral';

  @override
  String get likert4 => 'Slightly Accurate';

  @override
  String get likert5 => 'Very Accurate';

  @override
  String get resultsTitle => 'Your Results';

  @override
  String get resultsSubtitle => 'Your Big Five personality profile';

  @override
  String get shareButton => 'Share Results';

  @override
  String get retakeButton => 'Retake Test';

  @override
  String get seeResultButton => 'See Result';

  @override
  String get traitExtraversion => 'Extraversion';

  @override
  String get traitAgreeableness => 'Agreeableness';

  @override
  String get traitConscientiousness => 'Conscientiousness';

  @override
  String get traitNeuroticism => 'Neuroticism';

  @override
  String get traitOpenness => 'Openness';

  @override
  String get sharePreviewTitle => 'Share Preview';

  @override
  String get shareFormatTelegram => 'Telegram';

  @override
  String get shareFormatStories => 'Stories';

  @override
  String get shareNow => 'Share Now';

  @override
  String get shareCardProfileLabel => 'Big Five Profile';

  @override
  String get shareCardWhoAreYou => 'Who are you?';

  @override
  String shareSheetText(String url) {
    return 'I discovered my Big Five personality profile with \"Who Am I?\" 🧠 What are yours?\n$url';
  }

  @override
  String get aboutTitle => 'About This Test';

  @override
  String get aboutScienceTitle => 'Scientific Basis';

  @override
  String get aboutScienceDesc =>
      'This test is based on the Mini-IPIP (Donnellan et al., 2006) — a 20-item measure of the Big Five personality traits that has been validated across many cultures. It measures Extraversion, Agreeableness, Conscientiousness, Neuroticism, and Openness.';

  @override
  String get aboutPrivacyTitle => 'Privacy';

  @override
  String get aboutPrivacyDesc =>
      'No data is collected. Your results stay on your device only — nothing is sent to a server, and no account is needed.';

  @override
  String get aboutDisclaimerTitle => 'Disclaimer';

  @override
  String get aboutDisclaimerDesc =>
      'This test is for self-reflection only — it is not designed to diagnose or predict anything. If you have questions about your personality, consult a professional.';

  @override
  String get aboutPrivacyOptions => 'Privacy Options';
}
