import 'models/love.dart';
import 'models/question.dart';

/// A single Love Language item: a first-person statement the user rates by
/// agreement (1 = strongly disagree, 5 = strongly agree).
class LoveItem implements TestItem {
  const LoveItem({
    required this.id,
    required this.language,
    required this.text,
  });

  @override
  final int id;

  /// Which love language this statement loads onto.
  final LoveLanguage language;

  @override
  final LocalizedText text;
}

/// The 25 Love Language items — 5 statements per language, interleaved.
/// All positively keyed: each simply counts toward its own language.
const List<LoveItem> kLoveItems = <LoveItem>[
  // ── Round 1 ──
  LoveItem(
    id: 1,
    language: LoveLanguage.wordsOfAffirmation,
    text: LocalizedText(
      en: 'Hearing "I love you" — and why — means a lot to me.',
      am: 'አንድ ሰው እንደሚወደኝ እና ለምን እንደሆነ ሲነግረኝ በጣም ደስ ይለኛል።',
    ),
  ),
  LoveItem(
    id: 2,
    language: LoveLanguage.qualityTime,
    text: LocalizedText(
      en: 'I feel most loved when someone gives me their undivided attention.',
      am: 'አንድ ሰው ሙሉ ትኩረቱን ሲሰጠኝ በጣም እንደተወደድኩ ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 3,
    language: LoveLanguage.receivingGifts,
    text: LocalizedText(
      en: 'A thoughtful gift makes me feel truly remembered.',
      am: 'አስተዋይነት የተሞላበት ስጦታ እንደታሰብኩኝ እንዲሰማኝ ያደርጋል።',
    ),
  ),
  LoveItem(
    id: 4,
    language: LoveLanguage.actsOfService,
    text: LocalizedText(
      en: 'I feel loved when someone helps me with a task or chore.',
      am: 'አንድ ሰው በሆነ ስራ ወይም ተግባር ሲያግዘኝ እንደተወደድኩ ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 5,
    language: LoveLanguage.physicalTouch,
    text: LocalizedText(
      en: 'A hug or a hand on my shoulder makes me feel connected.',
      am: 'እቅፍ ወይም ትከሻዬ ላይ የሚደረግ ንክኪ የቅርበት ስሜት ይፈጥርብኛል።',
    ),
  ),

  // ── Round 2 ──
  LoveItem(
    id: 6,
    language: LoveLanguage.wordsOfAffirmation,
    text: LocalizedText(
      en: 'Compliments and words of appreciation make my day.',
      am: 'ምስጋና እና የአድናቆት ቃላት ቀኔን ያሳምሩታል።',
    ),
  ),
  LoveItem(
    id: 7,
    language: LoveLanguage.qualityTime,
    text: LocalizedText(
      en: 'Uninterrupted time together means more to me than gifts.',
      am: 'ያለ ምንም መረበሽ አብረን የምናሳልፈው ጊዜ ከስጦታ በላይ ዋጋ አለው።',
    ),
  ),
  LoveItem(
    id: 8,
    language: LoveLanguage.receivingGifts,
    text: LocalizedText(
      en: 'I treasure small tokens that show someone was thinking of me.',
      am: 'አንድ ሰው እንዳሰበኝ የሚያሳዩ ትናንሽ የማስታወሻ ስጦታዎችን ከፍ አድርጌ እመለከታለሁ።',
    ),
  ),
  LoveItem(
    id: 9,
    language: LoveLanguage.actsOfService,
    text: LocalizedText(
      en: 'Actions that make my life easier mean more than words.',
      am: 'ህይወቴን የሚያቀሉልኝ ተግባራት ከቃላት በላይ ትርጉም አላቸው።',
    ),
  ),
  LoveItem(
    id: 10,
    language: LoveLanguage.physicalTouch,
    text: LocalizedText(
      en: 'Physical closeness is how I feel most reassured.',
      am: 'አካላዊ ቅርበት የመረጋጋት እና የደህንነት ስሜት ይሰጠኛል።',
    ),
  ),

  // ── Round 3 ──
  LoveItem(
    id: 11,
    language: LoveLanguage.wordsOfAffirmation,
    text: LocalizedText(
      en: 'I feel loved when someone encourages me with their words.',
      am: 'አንድ ሰው በቃላቱ ሲያበረታታኝ እንደተወደድኩ ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 12,
    language: LoveLanguage.qualityTime,
    text: LocalizedText(
      en: 'I feel close to people when we do activities together.',
      am: 'ከሰዎች ጋር አብረን የሆነ ነገር ስንሰራ የቅርበት ስሜት ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 13,
    language: LoveLanguage.receivingGifts,
    text: LocalizedText(
      en: 'Receiving a present, however small, makes me feel loved.',
      am: 'ስጦታ መቀበል፣ ትንሽም ብትሆን፣ እንደተወደድኩ እንዲሰማኝ ያደርጋል።',
    ),
  ),
  LoveItem(
    id: 14,
    language: LoveLanguage.actsOfService,
    text: LocalizedText(
      en: 'When someone does something practical for me, I feel cared for.',
      am: 'አንድ ሰው የሚጠቅም ነገር ሲያደርግልኝ እንክብካቤ እንደተደረገልኝ ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 15,
    language: LoveLanguage.physicalTouch,
    text: LocalizedText(
      en: 'I feel loved through affectionate touch.',
      am: 'ፍቅር የተሞላበት ንክኪ የመወደድ ስሜት ይሰጠኛል።',
    ),
  ),

  // ── Round 4 ──
  LoveItem(
    id: 16,
    language: LoveLanguage.wordsOfAffirmation,
    text: LocalizedText(
      en: 'A heartfelt note or message makes me feel truly valued.',
      am: 'ከልብ የተጻፈ ማስታወሻ ወይም መልዕክት ዋጋ እንዳለኝ እንዲሰማኝ ያደርጋል።',
    ),
  ),
  LoveItem(
    id: 17,
    language: LoveLanguage.qualityTime,
    text: LocalizedText(
      en: 'A deep one-on-one conversation makes me feel cared for.',
      am: 'ከአንድ ሰው ጋር ብቻ የማደርገው ጥልቅ ውይይት እንክብካቤ እንደተደረገልኝ እንዲሰማኝ ያደርጋል።',
    ),
  ),
  LoveItem(
    id: 18,
    language: LoveLanguage.receivingGifts,
    text: LocalizedText(
      en: 'The effort behind a gift matters more to me than its price.',
      am: 'ከስጦታው ዋጋ ይልቅ በስተጀርባ ያለው ጥረት ለእኔ ትልቅ ትርጉም አለው።',
    ),
  ),
  LoveItem(
    id: 19,
    language: LoveLanguage.actsOfService,
    text: LocalizedText(
      en: 'I appreciate it most when people show love by helping out.',
      am: 'ሰዎች ፍቅራቸውን በማገዝ ሲገልጹልኝ በጣም አደንቃለሁ።',
    ),
  ),
  LoveItem(
    id: 20,
    language: LoveLanguage.physicalTouch,
    text: LocalizedText(
      en: 'Sitting close to someone comforts me.',
      am: 'ከአንድ ሰው አጠገብ ተጠግቶ መቀመጥ የመጽናናት ስሜት ይሰጠኛል።',
    ),
  ),

  // ── Round 5 ──
  LoveItem(
    id: 21,
    language: LoveLanguage.wordsOfAffirmation,
    text: LocalizedText(
      en: 'Kind, affirming words stay with me for a long time.',
      am: 'ደግ እና አበረታች ቃላት ለረጅም ጊዜ ከአእምሮዬ አይጠፉም።',
    ),
  ),
  LoveItem(
    id: 22,
    language: LoveLanguage.qualityTime,
    text: LocalizedText(
      en: 'Focused, device-free time together is how I feel connected.',
      am: 'ከስልኮችና ሌሎች ረባሾች ርቀን ትኩረት ሰጥተን አብረን ጊዜ ስናሳልፍ የቅርበት ስሜት ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 23,
    language: LoveLanguage.receivingGifts,
    text: LocalizedText(
      en: "I keep meaningful gifts because they remind me I'm cared for.",
      am: 'ትርጉም ያላቸውን ስጦታዎች የምጠብቀው እንክብካቤ እንደተደረገልኝ ስለሚያስታውሱኝ ነው።',
    ),
  ),
  LoveItem(
    id: 24,
    language: LoveLanguage.actsOfService,
    text: LocalizedText(
      en: 'Someone taking a burden off my plate makes me feel supported.',
      am: 'አንድ ሰው ሸክሜን ሲያቀልልኝ ድጋፍ እንደተደረገልኝ ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 25,
    language: LoveLanguage.physicalTouch,
    text: LocalizedText(
      en: 'A warm embrace can lift my mood instantly.',
      am: 'ሞቅ ያለ እቅፍ ስሜቴን በቅጽበት ያነቃቃዋል።',
    ),
  ),
];
