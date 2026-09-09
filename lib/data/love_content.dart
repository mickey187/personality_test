import 'models/love.dart';
import 'models/question.dart';
import 'ranked_content.dart';

/// Description + a practical tip per love language, English and Amharic.
/// Framed for self-reflection — the five love languages are a popular model,
/// not an empirically validated construct.
const Map<LoveLanguage, RankedContent> kLoveContent =
    <LoveLanguage, RankedContent>{
  LoveLanguage.wordsOfAffirmation: RankedContent(
    description: LocalizedText(
      en: 'You feel most loved through spoken and written affirmation — praise, '
          'encouragement, and hearing why you matter.',
      am: 'በንግግርና በጽሑፍ በሚገለጽ አድናቆት — ውዳሴ፣ ማበረታታትና ለምን ዋጋ እንዳለህ መስማት — በጣም '
          'የመወደድ ስሜት ይሰማሃል።',
    ),
    tip: LocalizedText(
      en: 'Ask the people you love for words of encouragement, and offer '
          'specific, genuine praise in return.',
      am: 'ከምትወዳቸው ሰዎች የማበረታቻ ቃላት ጠይቅ፣ በምላሹም የተለየና እውነተኛ ውዳሴ ስጥ።',
    ),
  ),
  LoveLanguage.qualityTime: RankedContent(
    description: LocalizedText(
      en: 'You feel most loved through focused, undivided attention — being '
          'truly present together matters more than anything.',
      am: 'ትኩረት በተሞላበት ሙሉ መገኘት — በእውነት አብሮ መገኘት ከማንኛውም ነገር ይበልጣል — በጣም የመወደድ ስሜት '
          'ይሰማሃል።',
    ),
    tip: LocalizedText(
      en: 'Protect device-free time with the people you love, and plan small '
          'shared activities.',
      am: 'ከምትወዳቸው ሰዎች ጋር ከስልክ ነጻ የሆነ ጊዜ ጠብቅ፣ ትንንሽ የጋራ እንቅስቃሴዎችንም አቅድ።',
    ),
  ),
  LoveLanguage.receivingGifts: RankedContent(
    description: LocalizedText(
      en: 'You feel most loved through thoughtful gifts — tangible symbols that '
          'show someone was thinking of you.',
      am: 'በጥንቃቄ በተመረጡ ስጦታዎች — አንድ ሰው እያሰበህ እንደነበር በሚያሳዩ ተጨባጭ ምልክቶች — በጣም የመወደድ '
          'ስሜት ይሰማሃል።',
    ),
    tip: LocalizedText(
      en: 'Share which small gifts feel meaningful to you, and notice the '
          'thought behind what others give.',
      am: 'የትኞቹ ትንንሽ ስጦታዎች ለአንተ ትርጉም እንዳላቸው አካፍል፣ ሌሎች በሚሰጡት ውስጥ ያለውን ሐሳብም አስተውል።',
    ),
  ),
  LoveLanguage.actsOfService: RankedContent(
    description: LocalizedText(
      en: 'You feel most loved through helpful actions — when someone eases '
          'your load, it speaks louder than words.',
      am: 'በሚረዱ ተግባራት — አንድ ሰው ሸክምህን ሲያቃልል፣ ከቃላት በላይ ይናገራል — በጣም የመወደድ ስሜት ይሰማሃል።',
    ),
    tip: LocalizedText(
      en: 'Tell people which practical help means most to you, and show love by '
          "lightening others' burdens.",
      am: 'የትኛው ተግባራዊ እገዛ ለአንተ እንደሚበልጥ ንገራቸው፣ የሌሎችንም ሸክም በማቃለል ፍቅርህን አሳይ።',
    ),
  ),
  LoveLanguage.physicalTouch: RankedContent(
    description: LocalizedText(
      en: 'You feel most loved through physical closeness — a hug, a touch, or '
          'simply sitting near someone reassures you.',
      am: 'በአካላዊ ቅርበት — እቅፍ፣ ንክኪ ወይም ከአንድ ሰው አጠገብ መቀመጥ — በጣም የመወደድ ስሜት ይሰማሃል፤ '
          'ያረጋጋሃልም።',
    ),
    tip: LocalizedText(
      en: 'Let loved ones know that touch matters to you, and offer warm, '
          'welcome gestures of closeness.',
      am: 'ንክኪ ለአንተ አስፈላጊ መሆኑን ለምትወዳቸው ሰዎች አሳውቅ፣ ሞቅ ያለና ተቀባይነት ያለው የቅርበት ምልክትም ስጥ።',
    ),
  ),
};
