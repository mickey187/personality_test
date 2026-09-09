import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Who Am I?'**
  String get appTitle;

  /// No description provided for @landingDesc.
  ///
  /// In en, this message translates to:
  /// **'Discover your personality — a science-based Big Five assessment in just 2 minutes.'**
  String get landingDesc;

  /// No description provided for @landingTime.
  ///
  /// In en, this message translates to:
  /// **'~2 minutes'**
  String get landingTime;

  /// No description provided for @landingScience.
  ///
  /// In en, this message translates to:
  /// **'Scientifically validated'**
  String get landingScience;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Know yourself — pick a test'**
  String get homeGreeting;

  /// No description provided for @soonBadge.
  ///
  /// In en, this message translates to:
  /// **'Soon'**
  String get soonBadge;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @startButton.
  ///
  /// In en, this message translates to:
  /// **'Start Test'**
  String get startButton;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @aboutLink.
  ///
  /// In en, this message translates to:
  /// **'About this test'**
  String get aboutLink;

  /// No description provided for @questionProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String questionProgress(int current, int total);

  /// No description provided for @likert1.
  ///
  /// In en, this message translates to:
  /// **'Very Inaccurate'**
  String get likert1;

  /// No description provided for @likert2.
  ///
  /// In en, this message translates to:
  /// **'Slightly Inaccurate'**
  String get likert2;

  /// No description provided for @likert3.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get likert3;

  /// No description provided for @likert4.
  ///
  /// In en, this message translates to:
  /// **'Slightly Accurate'**
  String get likert4;

  /// No description provided for @likert5.
  ///
  /// In en, this message translates to:
  /// **'Very Accurate'**
  String get likert5;

  /// No description provided for @careerLikert1.
  ///
  /// In en, this message translates to:
  /// **'Strongly Dislike'**
  String get careerLikert1;

  /// No description provided for @careerLikert2.
  ///
  /// In en, this message translates to:
  /// **'Dislike'**
  String get careerLikert2;

  /// No description provided for @careerLikert3.
  ///
  /// In en, this message translates to:
  /// **'Unsure'**
  String get careerLikert3;

  /// No description provided for @careerLikert4.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get careerLikert4;

  /// No description provided for @careerLikert5.
  ///
  /// In en, this message translates to:
  /// **'Strongly Like'**
  String get careerLikert5;

  /// No description provided for @agreeLikert1.
  ///
  /// In en, this message translates to:
  /// **'Strongly Disagree'**
  String get agreeLikert1;

  /// No description provided for @agreeLikert2.
  ///
  /// In en, this message translates to:
  /// **'Disagree'**
  String get agreeLikert2;

  /// No description provided for @agreeLikert3.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get agreeLikert3;

  /// No description provided for @agreeLikert4.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agreeLikert4;

  /// No description provided for @agreeLikert5.
  ///
  /// In en, this message translates to:
  /// **'Strongly Agree'**
  String get agreeLikert5;

  /// No description provided for @resultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Results'**
  String get resultsTitle;

  /// No description provided for @resultsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your Big Five personality profile'**
  String get resultsSubtitle;

  /// No description provided for @shareButton.
  ///
  /// In en, this message translates to:
  /// **'Share Results'**
  String get shareButton;

  /// No description provided for @retakeButton.
  ///
  /// In en, this message translates to:
  /// **'Retake Test'**
  String get retakeButton;

  /// No description provided for @seeResultButton.
  ///
  /// In en, this message translates to:
  /// **'See Result'**
  String get seeResultButton;

  /// No description provided for @traitExtraversion.
  ///
  /// In en, this message translates to:
  /// **'Extraversion'**
  String get traitExtraversion;

  /// No description provided for @traitAgreeableness.
  ///
  /// In en, this message translates to:
  /// **'Agreeableness'**
  String get traitAgreeableness;

  /// No description provided for @traitConscientiousness.
  ///
  /// In en, this message translates to:
  /// **'Conscientiousness'**
  String get traitConscientiousness;

  /// No description provided for @traitNeuroticism.
  ///
  /// In en, this message translates to:
  /// **'Neuroticism'**
  String get traitNeuroticism;

  /// No description provided for @traitOpenness.
  ///
  /// In en, this message translates to:
  /// **'Openness'**
  String get traitOpenness;

  /// No description provided for @careerResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Career Profile'**
  String get careerResultsTitle;

  /// No description provided for @careerResultsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your RIASEC interest profile'**
  String get careerResultsSubtitle;

  /// No description provided for @careerCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Your interest code'**
  String get careerCodeLabel;

  /// No description provided for @careerTopInterests.
  ///
  /// In en, this message translates to:
  /// **'Your top interests'**
  String get careerTopInterests;

  /// No description provided for @careersThatFit.
  ///
  /// In en, this message translates to:
  /// **'Careers that fit you'**
  String get careersThatFit;

  /// No description provided for @onetAttribution.
  ///
  /// In en, this message translates to:
  /// **'Interest items adapted from the O*NET Interest Profiler, U.S. Dept. of Labor (CC BY 4.0).'**
  String get onetAttribution;

  /// No description provided for @careerShareText.
  ///
  /// In en, this message translates to:
  /// **'My career interest code is {code} — I discovered careers that fit me with \"Who Am I?\" 🧭 What\'s yours?\n{url}'**
  String careerShareText(String code, String url);

  /// No description provided for @riasecRealistic.
  ///
  /// In en, this message translates to:
  /// **'Realistic (Doers)'**
  String get riasecRealistic;

  /// No description provided for @riasecInvestigative.
  ///
  /// In en, this message translates to:
  /// **'Investigative (Thinkers)'**
  String get riasecInvestigative;

  /// No description provided for @riasecArtistic.
  ///
  /// In en, this message translates to:
  /// **'Artistic (Creators)'**
  String get riasecArtistic;

  /// No description provided for @riasecSocial.
  ///
  /// In en, this message translates to:
  /// **'Social (Helpers)'**
  String get riasecSocial;

  /// No description provided for @riasecEnterprising.
  ///
  /// In en, this message translates to:
  /// **'Enterprising (Persuaders)'**
  String get riasecEnterprising;

  /// No description provided for @riasecConventional.
  ///
  /// In en, this message translates to:
  /// **'Conventional (Organizers)'**
  String get riasecConventional;

  /// No description provided for @eqResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your EQ Profile'**
  String get eqResultsTitle;

  /// No description provided for @eqResultsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your emotional intelligence across four skills'**
  String get eqResultsSubtitle;

  /// No description provided for @eqOverallLabel.
  ///
  /// In en, this message translates to:
  /// **'Your EQ score'**
  String get eqOverallLabel;

  /// No description provided for @eqStrengthsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your strengths'**
  String get eqStrengthsTitle;

  /// No description provided for @eqGrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'Where to grow'**
  String get eqGrowthTitle;

  /// No description provided for @eqLevelDeveloping.
  ///
  /// In en, this message translates to:
  /// **'Developing'**
  String get eqLevelDeveloping;

  /// No description provided for @eqLevelBalanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced'**
  String get eqLevelBalanced;

  /// No description provided for @eqLevelStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get eqLevelStrong;

  /// No description provided for @eqAttribution.
  ///
  /// In en, this message translates to:
  /// **'Based on the Wong & Law Emotional Intelligence Scale (WLEIS) and the Mayer–Salovey four-branch model.'**
  String get eqAttribution;

  /// No description provided for @eqSelfAppraisal.
  ///
  /// In en, this message translates to:
  /// **'Understanding Yourself'**
  String get eqSelfAppraisal;

  /// No description provided for @eqOthersAppraisal.
  ///
  /// In en, this message translates to:
  /// **'Reading Others'**
  String get eqOthersAppraisal;

  /// No description provided for @eqUseOfEmotion.
  ///
  /// In en, this message translates to:
  /// **'Using Emotions'**
  String get eqUseOfEmotion;

  /// No description provided for @eqRegulation.
  ///
  /// In en, this message translates to:
  /// **'Managing Emotions'**
  String get eqRegulation;

  /// No description provided for @eqShareText.
  ///
  /// In en, this message translates to:
  /// **'My EQ score is {percent}% ({level}) — I discovered my emotional intelligence profile with \"Who Am I?\" 🧠 What\'s yours?\n{url}'**
  String eqShareText(int percent, String level, String url);

  /// No description provided for @loveResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Love Language'**
  String get loveResultsTitle;

  /// No description provided for @loveResultsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How you give and receive love'**
  String get loveResultsSubtitle;

  /// No description provided for @lovePrimaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Your primary love language'**
  String get lovePrimaryLabel;

  /// No description provided for @loveMeaningTitle.
  ///
  /// In en, this message translates to:
  /// **'What this means for you'**
  String get loveMeaningTitle;

  /// No description provided for @loveTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'How to connect'**
  String get loveTipsTitle;

  /// No description provided for @loveAttribution.
  ///
  /// In en, this message translates to:
  /// **'Based on Gary Chapman\'s Five Love Languages — a popular framework, not a validated measure.'**
  String get loveAttribution;

  /// No description provided for @loveShareText.
  ///
  /// In en, this message translates to:
  /// **'My primary love language is {value} — I found out with \"Who Am I?\" ❤️ What\'s yours?\n{url}'**
  String loveShareText(String value, String url);

  /// No description provided for @loveWordsOfAffirmation.
  ///
  /// In en, this message translates to:
  /// **'Words of Affirmation'**
  String get loveWordsOfAffirmation;

  /// No description provided for @loveQualityTime.
  ///
  /// In en, this message translates to:
  /// **'Quality Time'**
  String get loveQualityTime;

  /// No description provided for @loveReceivingGifts.
  ///
  /// In en, this message translates to:
  /// **'Receiving Gifts'**
  String get loveReceivingGifts;

  /// No description provided for @loveActsOfService.
  ///
  /// In en, this message translates to:
  /// **'Acts of Service'**
  String get loveActsOfService;

  /// No description provided for @lovePhysicalTouch.
  ///
  /// In en, this message translates to:
  /// **'Physical Touch'**
  String get lovePhysicalTouch;

  /// No description provided for @leadershipResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Leadership Style'**
  String get leadershipResultsTitle;

  /// No description provided for @leadershipResultsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The styles you lead with'**
  String get leadershipResultsSubtitle;

  /// No description provided for @leadershipPrimaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Your dominant style'**
  String get leadershipPrimaryLabel;

  /// No description provided for @leadershipStylesTitle.
  ///
  /// In en, this message translates to:
  /// **'Your top styles'**
  String get leadershipStylesTitle;

  /// No description provided for @leadershipFlexTitle.
  ///
  /// In en, this message translates to:
  /// **'When to use them'**
  String get leadershipFlexTitle;

  /// No description provided for @leadershipAttribution.
  ///
  /// In en, this message translates to:
  /// **'Based on Daniel Goleman\'s six leadership styles (HBR, 2000).'**
  String get leadershipAttribution;

  /// No description provided for @leadershipShareText.
  ///
  /// In en, this message translates to:
  /// **'My dominant leadership style is {value} — I found out with \"Who Am I?\" 🎯 What\'s yours?\n{url}'**
  String leadershipShareText(String value, String url);

  /// No description provided for @leadershipVisionary.
  ///
  /// In en, this message translates to:
  /// **'Visionary'**
  String get leadershipVisionary;

  /// No description provided for @leadershipCoaching.
  ///
  /// In en, this message translates to:
  /// **'Coaching'**
  String get leadershipCoaching;

  /// No description provided for @leadershipAffiliative.
  ///
  /// In en, this message translates to:
  /// **'Affiliative'**
  String get leadershipAffiliative;

  /// No description provided for @leadershipDemocratic.
  ///
  /// In en, this message translates to:
  /// **'Democratic'**
  String get leadershipDemocratic;

  /// No description provided for @leadershipPacesetting.
  ///
  /// In en, this message translates to:
  /// **'Pacesetting'**
  String get leadershipPacesetting;

  /// No description provided for @leadershipCommanding.
  ///
  /// In en, this message translates to:
  /// **'Commanding'**
  String get leadershipCommanding;

  /// No description provided for @learningResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Learning Style'**
  String get learningResultsTitle;

  /// No description provided for @learningResultsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How you prefer to learn'**
  String get learningResultsSubtitle;

  /// No description provided for @learningPrimaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Your primary learning style'**
  String get learningPrimaryLabel;

  /// No description provided for @learningBestTitle.
  ///
  /// In en, this message translates to:
  /// **'How you learn best'**
  String get learningBestTitle;

  /// No description provided for @learningTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Study tips'**
  String get learningTipsTitle;

  /// No description provided for @learningAttribution.
  ///
  /// In en, this message translates to:
  /// **'Based on the VARK model (Fleming) — a popular preference framework, not a validated predictor of outcomes.'**
  String get learningAttribution;

  /// No description provided for @learningShareText.
  ///
  /// In en, this message translates to:
  /// **'My primary learning style is {value} — I found out with \"Who Am I?\" 📚 What\'s yours?\n{url}'**
  String learningShareText(String value, String url);

  /// No description provided for @learningVisual.
  ///
  /// In en, this message translates to:
  /// **'Visual'**
  String get learningVisual;

  /// No description provided for @learningAuditory.
  ///
  /// In en, this message translates to:
  /// **'Auditory'**
  String get learningAuditory;

  /// No description provided for @learningReadingWriting.
  ///
  /// In en, this message translates to:
  /// **'Reading / Writing'**
  String get learningReadingWriting;

  /// No description provided for @learningKinesthetic.
  ///
  /// In en, this message translates to:
  /// **'Kinesthetic'**
  String get learningKinesthetic;

  /// No description provided for @sharePreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Preview'**
  String get sharePreviewTitle;

  /// No description provided for @shareFormatTelegram.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get shareFormatTelegram;

  /// No description provided for @shareFormatStories.
  ///
  /// In en, this message translates to:
  /// **'Stories'**
  String get shareFormatStories;

  /// No description provided for @shareNow.
  ///
  /// In en, this message translates to:
  /// **'Share Now'**
  String get shareNow;

  /// No description provided for @shareCardProfileLabel.
  ///
  /// In en, this message translates to:
  /// **'Big Five Profile'**
  String get shareCardProfileLabel;

  /// No description provided for @shareCardWhoAreYou.
  ///
  /// In en, this message translates to:
  /// **'Who are you?'**
  String get shareCardWhoAreYou;

  /// No description provided for @shareSheetText.
  ///
  /// In en, this message translates to:
  /// **'I discovered my Big Five personality profile with \"Who Am I?\" 🧠 What are yours?\n{url}'**
  String shareSheetText(String url);

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About This Test'**
  String get aboutTitle;

  /// No description provided for @aboutScienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Scientific Basis'**
  String get aboutScienceTitle;

  /// No description provided for @aboutScienceDesc.
  ///
  /// In en, this message translates to:
  /// **'This test is based on the Mini-IPIP (Donnellan et al., 2006) — a 20-item measure of the Big Five personality traits that has been validated across many cultures. It measures Extraversion, Agreeableness, Conscientiousness, Neuroticism, and Openness.'**
  String get aboutScienceDesc;

  /// No description provided for @aboutPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get aboutPrivacyTitle;

  /// No description provided for @aboutPrivacyDesc.
  ///
  /// In en, this message translates to:
  /// **'No data is collected. Your results stay on your device only — nothing is sent to a server, and no account is needed.'**
  String get aboutPrivacyDesc;

  /// No description provided for @aboutDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get aboutDisclaimerTitle;

  /// No description provided for @aboutDisclaimerDesc.
  ///
  /// In en, this message translates to:
  /// **'This test is for self-reflection only — it is not designed to diagnose or predict anything. If you have questions about your personality, consult a professional.'**
  String get aboutDisclaimerDesc;

  /// No description provided for @aboutPrivacyOptions.
  ///
  /// In en, this message translates to:
  /// **'Privacy Options'**
  String get aboutPrivacyOptions;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['am', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
