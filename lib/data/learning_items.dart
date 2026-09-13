import 'models/learning.dart';
import 'models/question.dart';

/// A single Learning Style item: a first-person statement the user rates by
/// agreement (1 = strongly disagree, 5 = strongly agree).
class LearningItem implements TestItem {
  const LearningItem({
    required this.id,
    required this.style,
    required this.text,
  });

  @override
  final int id;

  /// Which VARK mode this statement loads onto.
  final LearningStyle style;

  @override
  final LocalizedText text;
}

/// The 20 Learning Style items — 5 statements per VARK mode, interleaved.
/// All positively keyed: each counts toward its own mode.
const List<LearningItem> kLearningItems = <LearningItem>[
  // ── Round 1 ──
  LearningItem(
    id: 1,
    style: LearningStyle.visual,
    text: LocalizedText(
      en:
          'I understand things best when I see them in diagrams, charts, or '
          'maps.',
      am: 'ነገሮችን በደንብ የምረዳው በስዕላዊ መግለጫዎች፣ በሰንጠረዦች ወይም በካርታዎች ሳያቸው ነው።',
    ),
  ),
  LearningItem(
    id: 2,
    style: LearningStyle.auditory,
    text: LocalizedText(
      en: 'I learn best by listening to explanations or lectures.',
      am: 'በደንብ የምማረው ማብራሪያዎችን ወይም ትምህርቶችን በማዳመጥ ነው።',
    ),
  ),
  LearningItem(
    id: 3,
    style: LearningStyle.readingWriting,
    text: LocalizedText(
      en: 'I learn best by reading and taking written notes.',
      am: 'በደንብ የምማረው በማንበብ እና ማስታወሻ በመያዝ ነው።',
    ),
  ),
  LearningItem(
    id: 4,
    style: LearningStyle.kinesthetic,
    text: LocalizedText(
      en: 'I learn best by doing things hands-on.',
      am: 'በደንብ የምማረው ነገሮችን በተግባር ስሰራቸው ነው።',
    ),
  ),

  // ── Round 2 ──
  LearningItem(
    id: 5,
    style: LearningStyle.visual,
    text: LocalizedText(
      en: "I remember information better when it's presented visually.",
      am: 'መረጃን በተሻለ ሁኔታ የማስታውሰው በምስል ሲቀርብልኝ ነው።',
    ),
  ),
  LearningItem(
    id: 6,
    style: LearningStyle.auditory,
    text: LocalizedText(
      en: 'I remember what people tell me more than what I read.',
      am: 'ካነበብኩት ይልቅ ሰዎች የነገሩኝን በደንብ አስታውሳለሁ።',
    ),
  ),
  LearningItem(
    id: 7,
    style: LearningStyle.readingWriting,
    text: LocalizedText(
      en: 'I understand ideas better when I write them down.',
      am: 'ሀሳቦችን በተሻለ የምረዳው በጽሑፍ ሳሰፍራቸው ነው።',
    ),
  ),
  LearningItem(
    id: 8,
    style: LearningStyle.kinesthetic,
    text: LocalizedText(
      en: 'I understand better when I can practice or try it myself.',
      am: 'እኔ ራሴ ስለማመደው ወይም ስሞክረው በተሻለ እረዳለሁ።',
    ),
  ),

  // ── Round 3 ──
  LearningItem(
    id: 9,
    style: LearningStyle.visual,
    text: LocalizedText(
      en: 'I like to picture ideas in my mind to understand them.',
      am: 'ሀሳቦችን ለመረዳት በአእምሮዬ ውስጥ መሳል እወዳለሁ።',
    ),
  ),
  LearningItem(
    id: 10,
    style: LearningStyle.auditory,
    text: LocalizedText(
      en: 'Talking a topic through helps me understand it.',
      am: 'ስለ አንድ ርዕስ መወያየት በደንብ እንድረዳው ይረዳኛል።',
    ),
  ),
  LearningItem(
    id: 11,
    style: LearningStyle.readingWriting,
    text: LocalizedText(
      en: 'I prefer instructions and information in written form.',
      am: 'መመሪያዎችን እና መረጃዎችን በጽሑፍ መቀበልን እመርጣለሁ።',
    ),
  ),
  LearningItem(
    id: 12,
    style: LearningStyle.kinesthetic,
    text: LocalizedText(
      en: "I remember things I've physically done more than things I've read.",
      am: 'ካነበብኳቸው ነገሮች ይልቅ በተግባር የሰራኋቸውን ነገሮች በደንብ አስታውሳለሁ።',
    ),
  ),

  // ── Round 4 ──
  LearningItem(
    id: 13,
    style: LearningStyle.visual,
    text: LocalizedText(
      en: 'Color-coding and highlighting help me organize what I learn.',
      am: 'የምማረውን ነገር ለማደራጀት በተለያዩ ቀለማት መለየትና ማጉላት ይረዳኛል።',
    ),
  ),
  LearningItem(
    id: 14,
    style: LearningStyle.auditory,
    text: LocalizedText(
      en: 'I often read aloud or repeat things to remember them.',
      am: 'ነገሮችን ለማስታወስ ብዙ ጊዜ ጮክ ብዬ አነባለሁ ወይም እደጋግማቸዋለሁ።',
    ),
  ),
  LearningItem(
    id: 15,
    style: LearningStyle.readingWriting,
    text: LocalizedText(
      en: 'Making lists and summaries helps me remember.',
      am: 'ዝርዝሮችን እና ማጠቃለያዎችን ማዘጋጀት ለማስታወስ ይረዳኛል።',
    ),
  ),
  LearningItem(
    id: 16,
    style: LearningStyle.kinesthetic,
    text: LocalizedText(
      en: 'I get restless learning by only sitting and listening.',
      am: 'በመቀመጥና በማዳመጥ ብቻ ስማር እቁነጠነጣለሁ።',
    ),
  ),

  // ── Round 5 ──
  LearningItem(
    id: 17,
    style: LearningStyle.visual,
    text: LocalizedText(
      en: 'When someone explains, I wish I could see it drawn out.',
      am: 'አንድ ሰው አንድን ነገር ሲያብራራልኝ በስዕል ባየው እመኛለሁ።',
    ),
  ),
  LearningItem(
    id: 18,
    style: LearningStyle.auditory,
    text: LocalizedText(
      en: 'Discussions and podcasts help me learn effectively.',
      am: 'ውይይቶች እና ፖድካስቶች ውጤታማ በሆነ መንገድ እንድማር ይረዱኛል።',
    ),
  ),
  LearningItem(
    id: 19,
    style: LearningStyle.readingWriting,
    text: LocalizedText(
      en: "I'd rather read a manual than watch a demonstration.",
      am: 'ተግባራዊ ማሳያን ከማየት ይልቅ የአጠቃቀም መመሪያ ማንበብን እመርጣለሁ።',
    ),
  ),
  LearningItem(
    id: 20,
    style: LearningStyle.kinesthetic,
    text: LocalizedText(
      en: 'Real examples and hands-on activities help me grasp ideas.',
      am: 'ተጨባጭ ምሳሌዎች እና ተግባራዊ ልምምዶች ሀሳቦችን በቀላሉ እንድገነዘብ ይረዱኛል።',
    ),
  ),
];
