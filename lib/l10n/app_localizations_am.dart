// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get appTitle => 'እኔ ማነኝ';

  @override
  String get landingDesc =>
      'ስብዕናዎን ይወቁ — በሳይንስ ላይ የተመሠረተ የ Big Five ምርመራ በ 2 ደቂቃ ውስጥ።';

  @override
  String get landingTime => '~2 ደቂቃ ብቻ';

  @override
  String get landingScience => 'በሳይንስ የተረጋገጠ';

  @override
  String get startButton => 'ጀምር';

  @override
  String get continueButton => 'ቀጥል';

  @override
  String get aboutLink => 'ስለ ምርመራው';

  @override
  String questionProgress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get likert1 => 'በጣም ስህተት';

  @override
  String get likert2 => 'ትንሽ ስህተት';

  @override
  String get likert3 => 'ገለልተኛ';

  @override
  String get likert4 => 'ትንሽ ትክክል';

  @override
  String get likert5 => 'በጣም ትክክል';

  @override
  String get resultsTitle => 'ውጤትዎ';

  @override
  String get resultsSubtitle => 'የ Big Five ስብዕና ገጽታዎ';

  @override
  String get shareButton => 'ውጤት አጋራ';

  @override
  String get retakeButton => 'እንደገና ውሰድ';

  @override
  String get seeResultButton => 'ውጤት ይመልከቱ';

  @override
  String get traitExtraversion => 'ግልጽነት (ኤክስትራቨርዥን)';

  @override
  String get traitAgreeableness => 'ደግነት (አግሪአብልነስ)';

  @override
  String get traitConscientiousness => 'ታታሪነት (ኮንሺየንሽስነስ)';

  @override
  String get traitNeuroticism => 'ስሜታዊነት (ኒውሮቲሲዝም)';

  @override
  String get traitOpenness => 'ክፍትነት (ኦፕንነስ)';

  @override
  String get sharePreviewTitle => 'ለማጋራት ይቅረቡ';

  @override
  String get shareFormatTelegram => 'Telegram';

  @override
  String get shareFormatStories => 'Stories';

  @override
  String get shareNow => 'አሁን አጋራ';

  @override
  String get shareCardProfileLabel => 'የ Big Five መገለጫ';

  @override
  String get shareCardWhoAreYou => 'አንተስ ማነህ?';

  @override
  String shareSheetText(String url) {
    return 'የ Big Five ስብዕና ውጤቴን በ«እኔ ማነኝ» አገኘሁ 🧠 አንተስ ማነህ?\n$url';
  }

  @override
  String get aboutTitle => 'ስለ ምርመራው';

  @override
  String get aboutScienceTitle => 'ሳይንሳዊ መሠረት';

  @override
  String get aboutScienceDesc =>
      'ይህ ምርመራ Mini-IPIP (Donnellan et al., 2006) ላይ የተመሠረተ ነው — 20 ጥያቄዎች ያሉት፣ በዓለም ዙሪያ ጥናት የተደረገበት Big Five ስብዕና ሞዴል። ኤክስትራቨርዥን፣ አግሪአብልነስ፣ ኮንሺየንሽስነስ፣ ኒውሮቲሲዝም እና ኦፕንነስ ይለካል።';

  @override
  String get aboutPrivacyTitle => 'ግላዊነት';

  @override
  String get aboutPrivacyDesc =>
      'ምንም ዳታ አይሰበሰብም። ውጤትዎ በስልክዎ ላይ ብቻ ይቀመጣል — ወደ ሰርቨር አይላክም፣ አካውንት አያስፈልግም።';

  @override
  String get aboutDisclaimerTitle => 'ማስታወቂያ';

  @override
  String get aboutDisclaimerDesc =>
      'ይህ ምርመራ ለራስ ግንዛቤ ብቻ ነው — ምርመራ ወይም ትንበያ ለማድረግ የተዘጋጀ አይደለም። ስለ ስብዕናዎ ጥያቄ ካለዎ ባለሙያ ያማክሩ።';
}
