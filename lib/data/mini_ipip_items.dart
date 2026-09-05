import 'models/question.dart';
import 'models/trait.dart';

/// The 20 Mini-IPIP items (Donnellan, Oswald, Baird & Lucas, 2006), a
/// public-domain short form of the IPIP Big Five scales.
///
/// English wording, trait assignment and reverse keys are the OFFICIAL
/// Mini-IPIP scoring key and must not be changed. Reverse-keyed items are
/// worded negatively ON PURPOSE — the Amharic keeps the negation; scoring
/// flips them (6 − r).
///
/// Amharic wording is the user-supplied official translation
/// (Mini-IPIP-English-for-Translation), which preserves each item's trait
/// framing and the reverse/contrary phrasing. Presentation order (ids 1–20)
/// follows the approved design, interleaving traits; the id is only a key, so
/// the order does not affect scoring.
///
/// Reverse-keyed ids: 6, 7, 8, 9, 10, 15, 16, 17, 18, 19, 20.
const List<Question> kMiniIpipItems = <Question>[
  Question(
    id: 1,
    trait: Trait.extraversion,
    reverseScored: false,
    text: LocalizedText(
      en: 'I am the life of the party',
      am: 'እኔ ሰው በሚሰበሰብበት ዝግጅት ላይ ጨዋታ አድማቂ ነኝ',
    ),
  ),
  Question(
    id: 2,
    trait: Trait.agreeableness,
    reverseScored: false,
    text: LocalizedText(
      en: "I sympathize with others' feelings",
      am: 'ለሌሎች ሰዎች ስሜት እራራለሁ።',
    ),
  ),
  Question(
    id: 3,
    trait: Trait.conscientiousness,
    reverseScored: false,
    text: LocalizedText(
      en: 'I get chores done right away',
      am: 'የቤት ውስጥ ስራዎችን (ተግባራትን) ወዲያውኑ አከናውናለሁ።',
    ),
  ),
  Question(
    id: 4,
    trait: Trait.neuroticism,
    reverseScored: false,
    text: LocalizedText(
      en: 'I have frequent mood swings',
      am: 'ቶሎ ቶሎ የሚለዋወጥ ስሜት አለኝ።',
    ),
  ),
  Question(
    id: 5,
    trait: Trait.openness,
    reverseScored: false,
    text: LocalizedText(
      en: 'I have a vivid imagination',
      am: 'ጥልቅ እና የዳበረ ምናብ አለኝ።',
    ),
  ),
  Question(
    id: 6,
    trait: Trait.extraversion,
    reverseScored: true,
    text: LocalizedText(
      en: "I don't talk a lot",
      am: 'ብዙም አላወራም',
    ),
  ),
  Question(
    id: 7,
    trait: Trait.agreeableness,
    reverseScored: true,
    text: LocalizedText(
      en: "I am not interested in other people's problems",
      am: 'የሌሎች ሰዎች ችግር አያሳስበኝም።',
    ),
  ),
  Question(
    id: 8,
    trait: Trait.conscientiousness,
    reverseScored: true,
    text: LocalizedText(
      en: 'I often forget to put things back in their proper place',
      am: 'ብዙ ጊዜ እቃዎችን ወደ ትክክለኛ ቦታቸው መመለስ እረሳለሁ።',
    ),
  ),
  Question(
    id: 9,
    trait: Trait.neuroticism,
    reverseScored: true,
    text: LocalizedText(
      en: 'I am relaxed most of the time',
      am: 'አብዛኛውን ጊዜ ዘና ያልኩ ነኝ።',
    ),
  ),
  Question(
    id: 10,
    trait: Trait.openness,
    reverseScored: true,
    text: LocalizedText(
      en: 'I am not interested in abstract ideas',
      am: 'ረቂቅ በሆኑ ሃሳቦች ላይ ፍላጎት የለኝም።',
    ),
  ),
  Question(
    id: 11,
    trait: Trait.extraversion,
    reverseScored: false,
    text: LocalizedText(
      en: 'I talk to a lot of different people at parties',
      am: 'በድግሶች ላይ ከተለያዩ ብዙ ሰዎች ጋር አወራለሁ።',
    ),
  ),
  Question(
    id: 12,
    trait: Trait.agreeableness,
    reverseScored: false,
    text: LocalizedText(
      en: "I feel others' emotions",
      am: 'የሌሎች ሰዎች ስሜትን እረዳለው',
    ),
  ),
  Question(
    id: 13,
    trait: Trait.conscientiousness,
    reverseScored: false,
    text: LocalizedText(
      en: 'I like order',
      am: 'ነገሮች በስርዓት እንዲሆኑ እወዳለሁ።',
    ),
  ),
  Question(
    id: 14,
    trait: Trait.neuroticism,
    reverseScored: false,
    text: LocalizedText(
      en: 'I get upset easily',
      am: 'ቶሎ እበሳጫለሁ።',
    ),
  ),
  Question(
    id: 15,
    trait: Trait.openness,
    reverseScored: true,
    text: LocalizedText(
      en: 'I have difficulty understanding abstract ideas',
      am: 'ረቂቅ ሃሳቦችን ለመረዳት እቸገራለሁ።',
    ),
  ),
  Question(
    id: 16,
    trait: Trait.extraversion,
    reverseScored: true,
    text: LocalizedText(
      en: 'I keep in the background',
      am: 'በማህበራዊ ቦታዎች ከዳር መሆንን እመርጣለሁ።',
    ),
  ),
  Question(
    id: 17,
    trait: Trait.agreeableness,
    reverseScored: true,
    text: LocalizedText(
      en: 'I am not really interested in others',
      am: 'በሌሎች ሰዎች ላይ ያን ያህል ፍላጎት የለኝም።',
    ),
  ),
  Question(
    id: 18,
    trait: Trait.conscientiousness,
    reverseScored: true,
    text: LocalizedText(
      en: 'I make a mess of things',
      am: 'ነገሮችን ይመሰቃቀሉብኛል',
    ),
  ),
  Question(
    id: 19,
    trait: Trait.neuroticism,
    reverseScored: true,
    text: LocalizedText(
      en: 'I seldom feel blue',
      am: 'የመከፋት ስሜት ብዙም አይሰማኝም።',
    ),
  ),
  Question(
    id: 20,
    trait: Trait.openness,
    reverseScored: true,
    text: LocalizedText(
      en: 'I do not have a good imagination',
      am: 'ጥሩ የሚባል የምናብ ችሎታ የለኝም።',
    ),
  ),
];
