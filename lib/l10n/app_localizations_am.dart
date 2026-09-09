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
  String get homeGreeting => 'ራስዎን ይወቁ — ምርመራ ይምረጡ';

  @override
  String get soonBadge => 'በቅርብ';

  @override
  String get comingSoon => 'በቅርብ ይመጣል';

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
  String get careerLikert1 => 'በጣም አልወድም';

  @override
  String get careerLikert2 => 'አልወድም';

  @override
  String get careerLikert3 => 'እርግጠኛ አይደለሁም';

  @override
  String get careerLikert4 => 'እወዳለሁ';

  @override
  String get careerLikert5 => 'በጣም እወዳለሁ';

  @override
  String get agreeLikert1 => 'በጣም አልስማማም';

  @override
  String get agreeLikert2 => 'አልስማማም';

  @override
  String get agreeLikert3 => 'ገለልተኛ';

  @override
  String get agreeLikert4 => 'እስማማለሁ';

  @override
  String get agreeLikert5 => 'በጣም እስማማለሁ';

  @override
  String get resultsTitle => 'ውጤትዎ';

  @override
  String get resultsSubtitle => 'የ Big Five ስብዕና ገጽታዎ';

  @override
  String get shareButton => 'ውጤት አጋራ';

  @override
  String get retakeButton => 'እንደገና ፈተናውን ውሰድ';

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
  String get careerResultsTitle => 'የሙያ መገለጫዎ';

  @override
  String get careerResultsSubtitle => 'የ RIASEC የፍላጎት መገለጫዎ';

  @override
  String get careerCodeLabel => 'የፍላጎት ኮድዎ';

  @override
  String get careerTopInterests => 'ዋና ዋና ፍላጎቶችዎ';

  @override
  String get careersThatFit => 'ለእርስዎ የሚስማሙ ሙያዎች';

  @override
  String get onetAttribution =>
      'የፍላጎት ጥያቄዎቹ ከ O*NET Interest Profiler (የአሜሪካ የሠራተኛ መሥሪያ ቤት፣ CC BY 4.0) የተወሰዱ ናቸው።';

  @override
  String careerShareText(String code, String url) {
    return 'የሙያ ፍላጎት ኮዴ $code ነው — ለእኔ የሚስማሙ ሙያዎችን በ«እኔ ማነኝ» አገኘሁ 🧭 አንተስ?\n$url';
  }

  @override
  String get riasecRealistic => 'ተግባራዊ (ሠሪዎች)';

  @override
  String get riasecInvestigative => 'መርማሪ (አሳቢዎች)';

  @override
  String get riasecArtistic => 'ጥበባዊ (ፈጣሪዎች)';

  @override
  String get riasecSocial => 'ማኅበራዊ (ረጂዎች)';

  @override
  String get riasecEnterprising => 'ሥራ ፈጣሪ (አሳማኞች)';

  @override
  String get riasecConventional => 'ሥርዓታዊ (አደራጆች)';

  @override
  String get eqResultsTitle => 'የ EQ መገለጫዎ';

  @override
  String get eqResultsSubtitle => 'ስሜታዊ ብልህነትዎ በአራት ክህሎቶች';

  @override
  String get eqOverallLabel => 'የ EQ ውጤትዎ';

  @override
  String get eqStrengthsTitle => 'ጥንካሬዎችዎ';

  @override
  String get eqGrowthTitle => 'የሚያሳድጉት';

  @override
  String get eqLevelDeveloping => 'በማደግ ላይ';

  @override
  String get eqLevelBalanced => 'ሚዛናዊ';

  @override
  String get eqLevelStrong => 'ጠንካራ';

  @override
  String get eqAttribution =>
      'በ Wong & Law Emotional Intelligence Scale (WLEIS) እና በ Mayer–Salovey ባለ አራት ቅርንጫፍ ሞዴል ላይ የተመሠረተ።';

  @override
  String get eqSelfAppraisal => 'ራስን መረዳት';

  @override
  String get eqOthersAppraisal => 'ሌሎችን ማንበብ';

  @override
  String get eqUseOfEmotion => 'ስሜትን መጠቀም';

  @override
  String get eqRegulation => 'ስሜትን ማስተዳደር';

  @override
  String eqShareText(int percent, String level, String url) {
    return 'የ EQ ውጤቴ $percent% ($level) ነው — ስሜታዊ ብልህነቴን በ«እኔ ማነኝ» አገኘሁ 🧠 አንተስ?\n$url';
  }

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

  @override
  String get aboutPrivacyOptions => 'የግላዊነት አማራጮች';
}
