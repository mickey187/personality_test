import 'models/eq.dart';
import 'models/question.dart';

/// A single EQ item: a first-person statement the user rates by agreement.
class EqItem implements TestItem {
  const EqItem({
    required this.id,
    required this.dimension,
    required this.reverseScored,
    required this.text,
  });

  /// 1-based presentation number (only a key — order does not affect scoring).
  @override
  final int id;

  /// Which EQ dimension this item loads onto.
  final EqDimension dimension;

  /// Whether the item is negatively keyed. Reverse-scored items are flipped
  /// (6 − response) during scoring; the wording stays negative on purpose.
  final bool reverseScored;

  /// First-person statement shown to the user, in each supported language.
  @override
  final LocalizedText text;
}

/// The 40 EQ items — 10 per dimension of the Wong & Law (WLEIS) model, which
/// operationalises the Mayer–Salovey four-branch ability model as self-report.
///
/// Item content adapts the WLEIS scale (Wong & Law, 2002) and additional
/// validated four-branch self-report items (Schutte et al., 1998). Each item is
/// rated 1–5 (Strongly Disagree → Strongly Agree); negatively-keyed items are
/// reverse-scored (6 − response). Presentation order (ids 1–40) interleaves the
/// four dimensions; the id is only a key, so order does not affect scoring.
const List<EqItem> kEqItems = <EqItem>[
  // ── Round 1 ──────────────────────────────────────────────────────────────
  EqItem(
    id: 1,
    dimension: EqDimension.selfAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'I have a good understanding of my own emotions.',
      am: 'የራሴን ስሜቶች በደንብ እረዳለሁ።',
    ),
  ),
  EqItem(
    id: 2,
    dimension: EqDimension.othersAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: "I am a good observer of other people's emotions.",
      am: 'የሌሎች ሰዎችን ስሜት በደንብ አስተውላለሁ።',
    ),
  ),
  EqItem(
    id: 3,
    dimension: EqDimension.useOfEmotion,
    reverseScored: false,
    text: LocalizedText(
      en: 'I am a self-motivated person.',
      am: 'ራሴን በራሴ አነሳሳለሁ።',
    ),
  ),
  EqItem(
    id: 4,
    dimension: EqDimension.regulation,
    reverseScored: false,
    text: LocalizedText(
      en: 'I can stay calm and handle difficulties rationally.',
      am: 'ተረጋግቼ ችግሮችን በምክንያታዊነት መወጣት እችላለሁ።',
    ),
  ),

  // ── Round 2 ──────────────────────────────────────────────────────────────
  EqItem(
    id: 5,
    dimension: EqDimension.selfAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'I really understand what I feel.',
      am: 'የሚሰማኝን ስሜት በትክክል እረዳለሁ።',
    ),
  ),
  EqItem(
    id: 6,
    dimension: EqDimension.othersAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'I am sensitive to the feelings and emotions of others.',
      am: 'የሌሎች ሰዎች ስሜት በቀላሉ ይገባኛል።',
    ),
  ),
  EqItem(
    id: 7,
    dimension: EqDimension.useOfEmotion,
    reverseScored: false,
    text: LocalizedText(
      en: 'I always encourage myself to try my best.',
      am: 'ምርጤን እንድሰራ ራሴን ሁሌም አበረታታለሁ።',
    ),
  ),
  EqItem(
    id: 8,
    dimension: EqDimension.regulation,
    reverseScored: false,
    text: LocalizedText(
      en: 'I am quite capable of controlling my own emotions.',
      am: 'የራሴን ስሜቶች በደንብ መቆጣጠር እችላለሁ።',
    ),
  ),

  // ── Round 3 ──────────────────────────────────────────────────────────────
  EqItem(
    id: 9,
    dimension: EqDimension.selfAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'I usually know why I feel the way I do.',
      am: 'አብዛኛውን ጊዜ ለምን እንደተሰማኝ ምክንያቱን አውቃለሁ።',
    ),
  ),
  EqItem(
    id: 10,
    dimension: EqDimension.othersAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'I can tell how people feel from their tone of voice.',
      am: 'ከሰዎች የድምፅ ቃና ስሜታቸውን መረዳት እችላለሁ።',
    ),
  ),
  EqItem(
    id: 11,
    dimension: EqDimension.useOfEmotion,
    reverseScored: false,
    text: LocalizedText(
      en: 'I set goals for myself and do my best to reach them.',
      am: 'ለራሴ ግቦችን አወጣና እነሱን ለማሳካት የተቻለኝን ሁሉ አደርጋለሁ።',
    ),
  ),
  EqItem(
    id: 12,
    dimension: EqDimension.regulation,
    reverseScored: false,
    text: LocalizedText(
      en: 'I can calm down quickly when I am very angry.',
      am: 'በጣም ስናደድ ቶሎ መረጋጋት እችላለሁ።',
    ),
  ),

  // ── Round 4 ──────────────────────────────────────────────────────────────
  EqItem(
    id: 13,
    dimension: EqDimension.selfAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'I can tell when my mood begins to change.',
      am: 'ስሜቴ መቀየር ሲጀምር አውቃለሁ።',
    ),
  ),
  EqItem(
    id: 14,
    dimension: EqDimension.othersAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: "I can read people's emotions from their facial expressions.",
      am: 'ከሰዎች የፊት ገጽታ ስሜታቸውን ማንበብ እችላለሁ።',
    ),
  ),
  EqItem(
    id: 15,
    dimension: EqDimension.useOfEmotion,
    reverseScored: false,
    text: LocalizedText(
      en: 'I use my good moods to keep trying when things get hard.',
      am: 'ነገሮች ሲከብዱ ጥረቴን እንድቀጥል ጥሩ ስሜቴን እጠቀምበታለሁ።',
    ),
  ),
  EqItem(
    id: 16,
    dimension: EqDimension.regulation,
    reverseScored: false,
    text: LocalizedText(
      en: 'I have good control over how I express my feelings.',
      am: 'ስሜቴን የምገልጽበትን መንገድ በደንብ መቆጣጠር እችላለሁ።',
    ),
  ),

  // ── Round 5 ──────────────────────────────────────────────────────────────
  EqItem(
    id: 17,
    dimension: EqDimension.selfAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'I am aware of my emotions as I experience them.',
      am: 'ስሜቶቼን በሚሰሙኝ ቅጽበት አውቃቸዋለሁ።',
    ),
  ),
  EqItem(
    id: 18,
    dimension: EqDimension.othersAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'I usually know what my friends feel from their behavior.',
      am: 'አብዛኛውን ጊዜ ከጓደኞቼ ባህሪ ምን እንደሚሰማቸው አውቃለሁ።',
    ),
  ),
  EqItem(
    id: 19,
    dimension: EqDimension.useOfEmotion,
    reverseScored: false,
    text: LocalizedText(
      en: 'When I am excited about something, I get much more done.',
      am: 'ስለ አንድ ነገር ስጓጓ ወይም ስደሰት ብዙ ስራዎችን አከናውናለሁ።',
    ),
  ),
  EqItem(
    id: 20,
    dimension: EqDimension.regulation,
    reverseScored: false,
    text: LocalizedText(
      en: 'I can steady myself soon after something upsetting happens.',
      am: 'የሚያበሳጭ ነገር ካጋጠመኝ በኋላ ቶሎ ራሴን ማረጋጋት እችላለሁ።',
    ),
  ),

  // ── Round 6 ──────────────────────────────────────────────────────────────
  EqItem(
    id: 21,
    dimension: EqDimension.selfAppraisal,
    reverseScored: true,
    text: LocalizedText(
      en: 'I often find it hard to make sense of my own feelings.',
      am: 'የራሴን ስሜቶች ትርጉም ለመረዳት ብዙ ጊዜ ይከብደኛል።',
    ),
  ),
  EqItem(
    id: 22,
    dimension: EqDimension.othersAppraisal,
    reverseScored: true,
    text: LocalizedText(
      en: 'I find it hard to tell when someone is upset.',
      am: 'አንድ ሰው ሲከፋው ወይም ሲበሳጭ ለማወቅ ይከብደኛል።',
    ),
  ),
  EqItem(
    id: 23,
    dimension: EqDimension.useOfEmotion,
    reverseScored: true,
    text: LocalizedText(
      en: 'My emotions rarely help me get things done.',
      am: 'ስሜቶቼ ስራን ለመስራት ብዙም አይረዱኝም።',
    ),
  ),
  EqItem(
    id: 24,
    dimension: EqDimension.regulation,
    reverseScored: true,
    text: LocalizedText(
      en: 'I lose control of my emotions more often than I would like.',
      am: 'ከምፈልገው በላይ ብዙ ጊዜ ስሜቶቼ ከቁጥጥሬ ውጪ ይሆናሉ።',
    ),
  ),

  // ── Round 7 ──────────────────────────────────────────────────────────────
  EqItem(
    id: 25,
    dimension: EqDimension.selfAppraisal,
    reverseScored: true,
    text: LocalizedText(
      en: 'Much of the time I am confused about how I really feel.',
      am: 'አብዛኛውን ጊዜ በትክክል ምን እንደሚሰማኝ ግራ ይገባኛል።',
    ),
  ),
  EqItem(
    id: 26,
    dimension: EqDimension.othersAppraisal,
    reverseScored: true,
    text: LocalizedText(
      en: 'I often misread how other people are feeling.',
      am: 'የሌሎች ሰዎችን ስሜት አብዛኛውን ጊዜ በተሳሳተ መንገድ እረዳለሁ።',
    ),
  ),
  EqItem(
    id: 27,
    dimension: EqDimension.useOfEmotion,
    reverseScored: true,
    text: LocalizedText(
      en: 'I struggle to turn my feelings into motivation.',
      am: 'ስሜቶቼን ወደ መነሳሳት ለመቀየር እቸገራለሁ።',
    ),
  ),
  EqItem(
    id: 28,
    dimension: EqDimension.regulation,
    reverseScored: true,
    text: LocalizedText(
      en: 'Once I get upset, it takes me a long time to settle down.',
      am: 'አንዴ ከተበሳጨሁ በኋላ ለመረጋጋት ረጅም ጊዜ ይፈጅብኛል።',
    ),
  ),

  // ── Round 8 ──────────────────────────────────────────────────────────────
  EqItem(
    id: 29,
    dimension: EqDimension.selfAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'When something upsets me, I can name the exact emotion.',
      am: 'የሚያስከፋኝ ነገር ሲያጋጥም የተሰማኝን ስሜት በትክክል መሰየም እችላለሁ።',
    ),
  ),
  EqItem(
    id: 30,
    dimension: EqDimension.othersAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'I can sense the mood of a group when I enter a room.',
      am: 'አንድ ክፍል ውስጥ ስገባ የቡድኑን ስሜት መረዳት እችላለሁ።',
    ),
  ),
  EqItem(
    id: 31,
    dimension: EqDimension.useOfEmotion,
    reverseScored: false,
    text: LocalizedText(
      en: 'I can put myself in a positive mood when I need energy.',
      am: 'ጉልበት በሚያስፈልገኝ ጊዜ ራሴን ጥሩ ስሜት ውስጥ ማስገባት እችላለሁ።',
    ),
  ),
  EqItem(
    id: 32,
    dimension: EqDimension.regulation,
    reverseScored: false,
    text: LocalizedText(
      en: 'I can keep disruptive emotions in check under pressure.',
      am: 'ጫና ውስጥ ስሆን የሚያውኩ ስሜቶችን መቆጣጠር እችላለሁ።',
    ),
  ),

  // ── Round 9 ──────────────────────────────────────────────────────────────
  EqItem(
    id: 33,
    dimension: EqDimension.selfAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'I understand what triggers my strongest emotions.',
      am: 'ኃይለኛ ስሜቶቼን ምን እንደሚቀሰቅሳቸው በደንብ እረዳለሁ።',
    ),
  ),
  EqItem(
    id: 34,
    dimension: EqDimension.othersAppraisal,
    reverseScored: false,
    text: LocalizedText(
      en: 'I notice when someone is hiding their true feelings.',
      am: 'አንድ ሰው እውነተኛ ስሜቱን ሲደብቅ አስተውላለሁ።',
    ),
  ),
  EqItem(
    id: 35,
    dimension: EqDimension.useOfEmotion,
    reverseScored: false,
    text: LocalizedText(
      en: 'I motivate myself by imagining a good outcome.',
      am: 'ጥሩ ውጤት እንደሚመጣ በማሰብ ራሴን አነሳሳለሁ።',
    ),
  ),
  EqItem(
    id: 36,
    dimension: EqDimension.regulation,
    reverseScored: false,
    text: LocalizedText(
      en: 'When I am stressed, I can stop it from taking over.',
      am: 'ውጥረት ውስጥ ስሆን ስሜቱ እንዳይቆጣጠረኝ ማድረግ እችላለሁ።',
    ),
  ),

  // ── Round 10 ─────────────────────────────────────────────────────────────
  EqItem(
    id: 37,
    dimension: EqDimension.selfAppraisal,
    reverseScored: true,
    text: LocalizedText(
      en: 'I am rarely sure what I am truly feeling.',
      am: 'በትክክል ምን እንደሚሰማኝ ብዙ ጊዜ እርግጠኛ አይደለሁም።',
    ),
  ),
  EqItem(
    id: 38,
    dimension: EqDimension.othersAppraisal,
    reverseScored: true,
    text: LocalizedText(
      en: "Other people's body language usually goes over my head.",
      am: 'የሌሎች ሰዎች የአካል ቋንቋ አብዛኛውን ጊዜ አይገባኝም።',
    ),
  ),
  EqItem(
    id: 39,
    dimension: EqDimension.useOfEmotion,
    reverseScored: false,
    text: LocalizedText(
      en: 'I tell myself I am capable when I face a challenge.',
      am: 'ፈተና ሲያጋጥመኝ \'ይህን ማድረግ እችላለሁ\' ብዬ ለራሴ እነግረዋለሁ።',
    ),
  ),
  EqItem(
    id: 40,
    dimension: EqDimension.regulation,
    reverseScored: true,
    text: LocalizedText(
      en: 'My feelings often get the better of me.',
      am: 'ስሜቶቼ ብዙ ጊዜ ያሸንፉኛል።',
    ),
  ),
];
