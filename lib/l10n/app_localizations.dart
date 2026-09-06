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
