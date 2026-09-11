import 'models/question.dart';
import 'models/trait.dart';

/// Descriptive copy for a trait: one description per score band.
class TraitContent {
  const TraitContent({required this.descriptions});

  /// Description shown at the user's [TraitLevel].
  final Map<TraitLevel, LocalizedText> descriptions;

  LocalizedText descriptionFor(TraitLevel level) => descriptions[level]!;
}

/// Trait descriptions at low/mid/high, English and Amharic, taken verbatim from
/// the approved "Personality Test" Claude Design source.
///
/// Copy is deliberately DESCRIPTIVE / self-insight framed — no career,
/// relationship, health, or predictive claims. Amharic is the designer's draft,
/// pending final translation + native review.
/// Plain-language captions for each Big Five trait, shown as the primary
/// label on the results screen (with the clinical term — e.g. "Big Five
/// trait: Neuroticism" — as a small secondary caption). Keeps the science
/// term available without leading with jargon.
const Map<Trait, LocalizedText> kTraitPlainLabel = <Trait, LocalizedText>{
  Trait.extraversion: LocalizedText(en: 'Social energy', am: 'ማህበራዊ ጉልበት'),
  Trait.agreeableness: LocalizedText(en: 'Compassion', am: 'አዛኝነት'),
  Trait.conscientiousness: LocalizedText(en: 'Self-discipline', am: 'ራስን መግዛት'),
  Trait.neuroticism: LocalizedText(
    en: 'Emotional sensitivity',
    am: 'ስሜታዊ ተጋላጭነት',
  ),
  Trait.openness: LocalizedText(
    en: 'Curiosity & imagination',
    am: 'ጉጉትና ምናብ',
  ),
};

const Map<Trait, TraitContent> kTraitContent = <Trait, TraitContent>{
  Trait.extraversion: TraitContent(
    descriptions: <TraitLevel, LocalizedText>{
      TraitLevel.high: LocalizedText(
        en: 'You thrive in social settings and draw energy from being around '
            'others.',
        am: 'ከሰዎች ጋር መሆን ያስደስትዎታል፣ ከሰዎች ጋር ሲሆኑ ጉልበት ያገኛሉ።',
      ),
      TraitLevel.mid: LocalizedText(
        en: 'You enjoy socializing but also value your alone time.',
        am: 'ከሰዎች ጋር መሆን ይወዳሉ ነገር ግን የብቻ ጊዜዎንም ያከብራሉ።',
      ),
      TraitLevel.low: LocalizedText(
        en: 'You prefer quieter settings and recharge through solitude.',
        am: 'ጸጥ ያለ ቦታ ይመርጣሉ፣ ብቻዎን ሆነው ጉልበት ያገኛሉ።',
      ),
    },
  ),
  Trait.agreeableness: TraitContent(
    descriptions: <TraitLevel, LocalizedText>{
      TraitLevel.high: LocalizedText(
        en: 'You are deeply attuned to the feelings and needs of those around '
            'you.',
        am: 'ለሌሎች ስሜትና ፍላጎት ጥልቅ ትኩረት ይሰጣሉ።',
      ),
      TraitLevel.mid: LocalizedText(
        en: 'You care about others while maintaining healthy boundaries.',
        am: 'ለሌሎች ያስባሉ ነገር ግን ጤናማ ወሰን ይጠብቃሉ።',
      ),
      TraitLevel.low: LocalizedText(
        en: 'You tend to prioritize logic over emotion in your decisions.',
        am: 'በውሳኔዎች ውስጥ ስሜትን ሳይሆን ምክንያታዊነትን ያስቀድማሉ።',
      ),
    },
  ),
  Trait.conscientiousness: TraitContent(
    descriptions: <TraitLevel, LocalizedText>{
      TraitLevel.high: LocalizedText(
        en: 'You are disciplined and organized, and follow through on your '
            'commitments.',
        am: 'ሥርዓተኛ ናቸው፣ ቃልዎን ይጠብቃሉ፣ ሥራዎን በጊዜ ይፈጽማሉ።',
      ),
      TraitLevel.mid: LocalizedText(
        en: 'You balance structure with flexibility in your daily life.',
        am: 'ሥርዓትንና ተለዋዋጭነትን ያጣጥማሉ።',
      ),
      TraitLevel.low: LocalizedText(
        en: 'You prefer spontaneity and flexibility over rigid structure.',
        am: 'ከጥብቅ ሥርዓት ይልቅ ተለዋዋጭነትንና ድንገተኝነትን ይመርጣሉ።',
      ),
    },
  ),
  Trait.neuroticism: TraitContent(
    descriptions: <TraitLevel, LocalizedText>{
      TraitLevel.high: LocalizedText(
        en: 'You tend to experience emotions intensely and may feel stressed '
            'under pressure.',
        am: 'ስሜትዎ ጠንካራ ነው፣ ጫና ሲኖር ውጥረት ሊሰማዎት ይችላል።',
      ),
      TraitLevel.mid: LocalizedText(
        en: 'You handle stress reasonably well, with occasional ups and downs.',
        am: 'ጫናን በተገቢ ሁኔታ ይቋቋማሉ፣ አልፎ አልፎ ውጣ ውረድ ቢኖርም።',
      ),
      TraitLevel.low: LocalizedText(
        en: 'You are emotionally steady and rarely feel overwhelmed by stress.',
        am: 'ስሜትዎ ጸጥ ያለ ነው፣ በጫና ብዙም አይናወጡም።',
      ),
    },
  ),
  Trait.openness: TraitContent(
    descriptions: <TraitLevel, LocalizedText>{
      TraitLevel.high: LocalizedText(
        en: 'You are curious and imaginative, drawn to new ideas and creative '
            'expression.',
        am: 'ጠያቂ ናቸው፣ አዳዲስ ሃሳቦችንና ፈጠራን ይወዳሉ።',
      ),
      TraitLevel.mid: LocalizedText(
        en: 'You appreciate both practical solutions and creative thinking.',
        am: 'ተግባራዊ መፍትሄንም ፈጠራዊ አስተሳሰብንም ያደንቃሉ።',
      ),
      TraitLevel.low: LocalizedText(
        en: 'You prefer concrete, practical thinking over abstract ideas.',
        am: 'ተጨባጭና ተግባራዊ አስተሳሰብ ይመርጣሉ።',
      ),
    },
  ),
};
