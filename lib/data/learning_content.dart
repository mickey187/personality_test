import 'models/learning.dart';
import 'models/question.dart';
import 'ranked_content.dart';

/// Description + a practical study tip per VARK mode, English and Amharic.
const Map<LearningStyle, RankedContent> kLearningContent =
    <LearningStyle, RankedContent>{
  LearningStyle.visual: RankedContent(
    description: LocalizedText(
      en: 'You learn best through seeing — diagrams, charts, images and spatial '
          'layouts help ideas click.',
      am: 'በማየት በተሻለ ትማራለህ — ሥዕላዊ መግለጫዎች፣ ሠንጠረዦች፣ ምስሎችና የቦታ አቀማመጦች ሃሳቦች እንዲገቡህ '
          'ይረዳሉ።',
    ),
    tip: LocalizedText(
      en: 'Turn notes into mind maps, diagrams and colour-coded visuals, and '
          'watch demonstrations.',
      am: 'ማስታወሻዎችን ወደ የአእምሮ ካርታ፣ ሥዕልና በቀለም ወደ ተለዩ ምስሎች ቀይር፤ ማሳያዎችንም ተመልከት።',
    ),
  ),
  LearningStyle.auditory: RankedContent(
    description: LocalizedText(
      en: 'You learn best through hearing — listening, discussing and talking '
          'ideas through help them stick.',
      am: 'በመስማት በተሻለ ትማራለህ — ማዳመጥ፣ መወያየትና ሃሳቦችን በንግግር ማብራራት እንዲቀሩ ይረዳሉ።',
    ),
    tip: LocalizedText(
      en: 'Listen to recordings, explain topics aloud, and study through '
          'discussion.',
      am: 'ቅጂዎችን አዳምጥ፣ ርዕሶችን ጮክ ብለህ አብራራ፣ በውይይትም አጥና።',
    ),
  ),
  LearningStyle.readingWriting: RankedContent(
    description: LocalizedText(
      en: 'You learn best through words — reading and writing notes, lists and '
          'summaries make ideas clear.',
      am: 'በቃላት በተሻለ ትማራለህ — ማንበብና ማስታወሻ፣ ዝርዝርና ማጠቃለያ መጻፍ ሃሳቦችን ግልጽ ያደርጋሉ።',
    ),
    tip: LocalizedText(
      en: 'Rewrite notes in your own words, make lists and summaries, and read '
          'widely.',
      am: 'ማስታወሻዎችን በራስህ ቃላት እንደገና ጻፍ፣ ዝርዝርና ማጠቃለያ ስራ፣ ብዙም አንብብ።',
    ),
  ),
  LearningStyle.kinesthetic: RankedContent(
    description: LocalizedText(
      en: 'You learn best by doing — hands-on practice, real examples and '
          'movement help ideas stick.',
      am: 'በተግባር በተሻለ ትማራለህ — በእጅ መለማመድ፣ እውነተኛ ምሳሌዎችና እንቅስቃሴ ሃሳቦች እንዲቀሩ ይረዳሉ።',
    ),
    tip: LocalizedText(
      en: 'Practise by doing, use real examples, and take active breaks while '
          'studying.',
      am: 'በተግባር ተለማመድ፣ እውነተኛ ምሳሌዎችን ተጠቀም፣ በጥናት ጊዜም ንቁ እረፍቶችን ውሰድ።',
    ),
  ),
};
