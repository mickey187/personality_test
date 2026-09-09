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
      am: '«እወድሃለሁ» እና ለምን እንደሆነ መስማት ለእኔ ብዙ ትርጉም አለው።',
    ),
  ),
  LoveItem(
    id: 2,
    language: LoveLanguage.qualityTime,
    text: LocalizedText(
      en: 'I feel most loved when someone gives me their undivided attention.',
      am: 'አንድ ሰው ሙሉ ትኩረቱን ሲሰጠኝ በጣም የመወደድ ስሜት ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 3,
    language: LoveLanguage.receivingGifts,
    text: LocalizedText(
      en: 'A thoughtful gift makes me feel truly remembered.',
      am: 'በጥንቃቄ የተመረጠ ስጦታ በእውነት እንደታሰብኩ ያሰማኛል።',
    ),
  ),
  LoveItem(
    id: 4,
    language: LoveLanguage.actsOfService,
    text: LocalizedText(
      en: 'I feel loved when someone helps me with a task or chore.',
      am: 'አንድ ሰው በሥራ ወይም በተግባር ሲረዳኝ የመወደድ ስሜት ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 5,
    language: LoveLanguage.physicalTouch,
    text: LocalizedText(
      en: 'A hug or a hand on my shoulder makes me feel connected.',
      am: 'እቅፍ ወይም በትከሻዬ ላይ የተቀመጠ እጅ የመቀራረብ ስሜት ይሰጠኛል።',
    ),
  ),

  // ── Round 2 ──
  LoveItem(
    id: 6,
    language: LoveLanguage.wordsOfAffirmation,
    text: LocalizedText(
      en: 'Compliments and words of appreciation make my day.',
      am: 'ምስጋናና የአድናቆት ቃላት ቀኔን ያሳምሩታል።',
    ),
  ),
  LoveItem(
    id: 7,
    language: LoveLanguage.qualityTime,
    text: LocalizedText(
      en: 'Uninterrupted time together means more to me than gifts.',
      am: 'ሳይቋረጥ አብሮ ማሳለፍ ከስጦታ በላይ ለእኔ ትርጉም አለው።',
    ),
  ),
  LoveItem(
    id: 8,
    language: LoveLanguage.receivingGifts,
    text: LocalizedText(
      en: 'I treasure small tokens that show someone was thinking of me.',
      am: 'አንድ ሰው እያሰበኝ እንደነበር የሚያሳዩ ትንንሽ ምልክቶችን አከብራለሁ።',
    ),
  ),
  LoveItem(
    id: 9,
    language: LoveLanguage.actsOfService,
    text: LocalizedText(
      en: 'Actions that make my life easier mean more than words.',
      am: 'ሕይወቴን የሚያቀሉ ተግባራት ከቃላት ይበልጣሉ።',
    ),
  ),
  LoveItem(
    id: 10,
    language: LoveLanguage.physicalTouch,
    text: LocalizedText(
      en: 'Physical closeness is how I feel most reassured.',
      am: 'አካላዊ ቅርበት ከሁሉም በላይ የመረጋጋት ስሜት ይሰጠኛል።',
    ),
  ),

  // ── Round 3 ──
  LoveItem(
    id: 11,
    language: LoveLanguage.wordsOfAffirmation,
    text: LocalizedText(
      en: 'I feel loved when someone encourages me with their words.',
      am: 'አንድ ሰው በቃላቱ ሲያበረታታኝ የመወደድ ስሜት ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 12,
    language: LoveLanguage.qualityTime,
    text: LocalizedText(
      en: 'I feel close to people when we do activities together.',
      am: 'አብረን ነገሮችን ስንሠራ ከሰዎች ጋር ቅርበት ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 13,
    language: LoveLanguage.receivingGifts,
    text: LocalizedText(
      en: 'Receiving a present, however small, makes me feel loved.',
      am: 'ስጦታ መቀበል፣ ትንሽም ቢሆን፣ የመወደድ ስሜት ይሰጠኛል።',
    ),
  ),
  LoveItem(
    id: 14,
    language: LoveLanguage.actsOfService,
    text: LocalizedText(
      en: 'When someone does something practical for me, I feel cared for.',
      am: 'አንድ ሰው ተግባራዊ የሆነ ነገር ሲያደርግልኝ እንደተከበርኩ ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 15,
    language: LoveLanguage.physicalTouch,
    text: LocalizedText(
      en: 'I feel loved through affectionate touch.',
      am: 'በፍቅር በተሞላ ንክኪ የመወደድ ስሜት ይሰማኛል።',
    ),
  ),

  // ── Round 4 ──
  LoveItem(
    id: 16,
    language: LoveLanguage.wordsOfAffirmation,
    text: LocalizedText(
      en: 'A heartfelt note or message makes me feel truly valued.',
      am: 'ከልብ የመጣ ማስታወሻ ወይም መልእክት በእውነት ዋጋ እንዳለኝ ያሰማኛል።',
    ),
  ),
  LoveItem(
    id: 17,
    language: LoveLanguage.qualityTime,
    text: LocalizedText(
      en: 'A deep one-on-one conversation makes me feel cared for.',
      am: 'ጥልቅ የሆነ የፊት ለፊት ጭውውት ማድረግ እንደተከበርኩ ያሰማኛል።',
    ),
  ),
  LoveItem(
    id: 18,
    language: LoveLanguage.receivingGifts,
    text: LocalizedText(
      en: 'The effort behind a gift matters more to me than its price.',
      am: 'ከስጦታው ዋጋ ይልቅ ከኋላው ያለው ጥረት ለእኔ ይበልጣል።',
    ),
  ),
  LoveItem(
    id: 19,
    language: LoveLanguage.actsOfService,
    text: LocalizedText(
      en: 'I appreciate it most when people show love by helping out.',
      am: 'ሰዎች በመርዳት ፍቅራቸውን ሲያሳዩ በጣም አደንቃለሁ።',
    ),
  ),
  LoveItem(
    id: 20,
    language: LoveLanguage.physicalTouch,
    text: LocalizedText(
      en: 'Sitting close to someone comforts me.',
      am: 'ከአንድ ሰው ጋር ተጠግቶ መቀመጥ ያጽናናኛል።',
    ),
  ),

  // ── Round 5 ──
  LoveItem(
    id: 21,
    language: LoveLanguage.wordsOfAffirmation,
    text: LocalizedText(
      en: 'Kind, affirming words stay with me for a long time.',
      am: 'ደግና አበረታች ቃላት ለረዥም ጊዜ ከእኔ ጋር ይቆያሉ።',
    ),
  ),
  LoveItem(
    id: 22,
    language: LoveLanguage.qualityTime,
    text: LocalizedText(
      en: 'Focused, device-free time together is how I feel connected.',
      am: 'ከስልክ ነጻ የሆነ ትኩረት የተሞላበት ጊዜ አብሮ ማሳለፍ የመቀራረብ ስሜት ይሰጠኛል።',
    ),
  ),
  LoveItem(
    id: 23,
    language: LoveLanguage.receivingGifts,
    text: LocalizedText(
      en: "I keep meaningful gifts because they remind me I'm cared for.",
      am: 'ትርጉም ያላቸውን ስጦታዎች እይዛቸዋለሁ፣ እንደተወደድኩ ስለሚያስታውሱኝ።',
    ),
  ),
  LoveItem(
    id: 24,
    language: LoveLanguage.actsOfService,
    text: LocalizedText(
      en: 'Someone taking a burden off my plate makes me feel supported.',
      am: 'አንድ ሰው ሸክሜን ሲያቃልልኝ ድጋፍ እንዳለኝ ይሰማኛል።',
    ),
  ),
  LoveItem(
    id: 25,
    language: LoveLanguage.physicalTouch,
    text: LocalizedText(
      en: 'A warm embrace can lift my mood instantly.',
      am: 'ሞቅ ያለ እቅፍ ስሜቴን ወዲያውኑ ከፍ ያደርገዋል።',
    ),
  ),
];
