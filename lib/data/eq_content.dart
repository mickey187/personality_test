import 'models/eq.dart';
import 'models/question.dart';

/// Descriptive copy for an EQ dimension: one line per score band plus a
/// practical growth tip shown when the dimension is among the user's weakest.
class EqContent {
  const EqContent({required this.descriptions, required this.tip});

  final Map<EqLevel, LocalizedText> descriptions;
  final LocalizedText tip;

  LocalizedText descriptionFor(EqLevel level) => descriptions[level]!;
}

/// Descriptions + growth tips per EQ dimension, English and Amharic.
///
/// Copy is descriptive / self-insight framed — no clinical or predictive
/// claims. The test is for reflection, not diagnosis.
const Map<EqDimension, EqContent> kEqContent = <EqDimension, EqContent>{
  EqDimension.selfAppraisal: EqContent(
    descriptions: <EqLevel, LocalizedText>{
      EqLevel.high: LocalizedText(
        en: 'You have a clear read on your own feelings — you notice them '
            'early and understand what drives them.',
        am: 'የራስዎን ስሜቶች በግልጽ ይረዳሉ — ቀድመው ያስተውሏቸዋል፣ መንስኤያቸውንም ያውቃሉ።',
      ),
      EqLevel.mid: LocalizedText(
        en: 'You often understand your feelings, though some emotions still '
            'catch you off guard.',
        am: 'ብዙ ጊዜ ስሜትዎን ይረዳሉ፣ ነገር ግን አንዳንድ ስሜቶች ሳይጠበቁ ይመጡብዎታል።',
      ),
      EqLevel.low: LocalizedText(
        en: 'Your inner emotional world can feel unclear — naming and tracing '
            'your feelings takes effort.',
        am: 'የውስጥ ስሜትዎ ግልጽ ላይሆን ይችላል — ስሜትዎን መሰየምና መንስኤውን መከታተል ጥረት ይጠይቃል።',
      ),
    },
    tip: LocalizedText(
      en: 'Try a daily check-in: once a day, pause and name what you feel and '
          'why.',
      am: 'በየቀኑ ራስዎን ይፈትሹ፦ በቀን አንዴ ቆም ብለው ምን እንደሚሰማዎትና ለምን እንደሆነ ይሰይሙ።',
    ),
  ),
  EqDimension.othersAppraisal: EqContent(
    descriptions: <EqLevel, LocalizedText>{
      EqLevel.high: LocalizedText(
        en: 'You read people well — you pick up on others’ feelings from even '
            'subtle cues.',
        am: 'ሰዎችን በደንብ ያነባሉ — ከጥቃቅን ምልክቶች እንኳ የሌሎችን ስሜት ይረዳሉ።',
      ),
      EqLevel.mid: LocalizedText(
        en: 'You usually sense how others feel, though some signals slip past '
            'you.',
        am: 'ብዙ ጊዜ ሌሎች ምን እንደሚሰማቸው ይረዳሉ፣ ነገር ግን አንዳንድ ምልክቶች ያመልጥዎታል።',
      ),
      EqLevel.low: LocalizedText(
        en: 'Reading other people’s emotions can be tricky, and cues are easy '
            'to miss.',
        am: 'የሌሎችን ስሜት ማንበብ ሊከብድ ይችላል፣ ምልክቶችም በቀላሉ ያመልጥዎታል።',
      ),
    },
    tip: LocalizedText(
      en: 'Watch faces and tone, not just words — ask yourself what the other '
          'person might be feeling.',
      am: 'ቃላትን ብቻ ሳይሆን ፊትንና ቃናን ይመልከቱ — ሌላው ሰው ምን ሊሰማው እንደሚችል ራስዎን ይጠይቁ።',
    ),
  ),
  EqDimension.useOfEmotion: EqContent(
    descriptions: <EqLevel, LocalizedText>{
      EqLevel.high: LocalizedText(
        en: 'You channel your emotions into motivation and use good moods to '
            'push through challenges.',
        am: 'ስሜትዎን ወደ መነሳሳት ይለውጣሉ፤ ጥሩ ስሜትዎን ተጠቅመው ፈተናዎችን ያልፋሉ።',
      ),
      EqLevel.mid: LocalizedText(
        en: 'You can harness your emotions to get going, though not always '
            'consistently.',
        am: 'ስሜትዎን ተጠቅመው መንቀሳቀስ ይችላሉ፣ ምንም እንኳ ሁልጊዜ በተከታታይ ባይሆንም።',
      ),
      EqLevel.low: LocalizedText(
        en: 'Turning feelings into drive and momentum can be hard for you.',
        am: 'ስሜትዎን ወደ ግፊትና መነሳሳት መቀየር ሊከብድዎት ይችላል።',
      ),
    },
    tip: LocalizedText(
      en: 'Before a hard task, picture the win — let that feeling fuel your '
          'first step.',
      am: 'ከባድ ሥራ ከመጀመርዎ በፊት ስኬቱን ይሳሉ — ያ ስሜት የመጀመሪያ እርምጃዎን ያንቀሳቅሰው።',
    ),
  ),
  EqDimension.regulation: EqContent(
    descriptions: <EqLevel, LocalizedText>{
      EqLevel.high: LocalizedText(
        en: 'You keep your emotions steady — staying calm and recovering '
            'quickly under pressure.',
        am: 'ስሜትዎን ረጋ ያደርጋሉ — በጫና ውስጥም ተረጋግተው ቶሎ ያገግማሉ።',
      ),
      EqLevel.mid: LocalizedText(
        en: 'You manage your emotions reasonably well, with the occasional '
            'wobble.',
        am: 'ስሜትዎን በተገቢ ሁኔታ ይቆጣጠራሉ፣ አልፎ አልፎ መንገራገጭ ቢኖርም።',
      ),
      EqLevel.low: LocalizedText(
        en: 'Strong emotions can take over, and settling down again takes '
            'time.',
        am: 'ጠንካራ ስሜቶች ሊቆጣጠሩዎት ይችላሉ፣ ዳግም ለመረጋጋትም ጊዜ ይወስዳል።',
      ),
    },
    tip: LocalizedText(
      en: 'When emotions surge, slow your breathing and pause before you '
          'react.',
      am: 'ስሜት ሲበረታ እስትንፋስዎን ያዝ ያድርጉ፣ ከመመለስዎ በፊትም ቆም ይበሉ።',
    ),
  ),
};

/// One-paragraph summary of the overall EQ score, per band. English and Amharic.
const Map<EqLevel, LocalizedText> kEqOverallContent = <EqLevel, LocalizedText>{
  EqLevel.high: LocalizedText(
    en: 'You show strong emotional intelligence — you understand emotions, in '
        'yourself and others, and put them to good use.',
    am: 'ጠንካራ ስሜታዊ ብልህነት ያሳያሉ — በራስዎም በሌሎችም ስሜቶችን ይረዳሉ፣ በጥሩ ሁኔታም ይጠቀሙባቸዋል።',
  ),
  EqLevel.mid: LocalizedText(
    en: 'You have a balanced emotional intelligence, with clear strengths and '
        'room to grow.',
    am: 'ሚዛናዊ ስሜታዊ ብልህነት አለዎት — ግልጽ ጥንካሬዎችም የማደግ ዕድልም አለዎት።',
  ),
  EqLevel.low: LocalizedText(
    en: 'Your emotional intelligence is still developing — small, steady '
        'habits can strengthen it over time.',
    am: 'ስሜታዊ ብልህነትዎ በማደግ ላይ ነው — ትንንሽ፣ ተከታታይ ልማዶች ከጊዜ ወደ ጊዜ ያጠናክሩታል።',
  ),
};
