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
      en: 'I understand things best when I see them in diagrams, charts, or '
          'maps.',
      am: 'ነገሮችን በሥዕላዊ መግለጫ፣ በሠንጠረዥ ወይም በካርታ ሳያቸው በተሻለ እረዳለሁ።',
    ),
  ),
  LearningItem(
    id: 2,
    style: LearningStyle.auditory,
    text: LocalizedText(
      en: 'I learn best by listening to explanations or lectures.',
      am: 'ማብራሪያዎችን ወይም ንግግሮችን በማዳመጥ በተሻለ እማራለሁ።',
    ),
  ),
  LearningItem(
    id: 3,
    style: LearningStyle.readingWriting,
    text: LocalizedText(
      en: 'I learn best by reading and taking written notes.',
      am: 'በማንበብና ጽሑፋዊ ማስታወሻ በመያዝ በተሻለ እማራለሁ።',
    ),
  ),
  LearningItem(
    id: 4,
    style: LearningStyle.kinesthetic,
    text: LocalizedText(
      en: 'I learn best by doing things hands-on.',
      am: 'ነገሮችን በተግባር በመሥራት በተሻለ እማራለሁ።',
    ),
  ),

  // ── Round 2 ──
  LearningItem(
    id: 5,
    style: LearningStyle.visual,
    text: LocalizedText(
      en: "I remember information better when it's presented visually.",
      am: 'መረጃ በምስል ሲቀርብልኝ በተሻለ አስታውሳለሁ።',
    ),
  ),
  LearningItem(
    id: 6,
    style: LearningStyle.auditory,
    text: LocalizedText(
      en: 'I remember what people tell me more than what I read.',
      am: 'ሰዎች የነገሩኝን ካነበብኩት በላይ አስታውሳለሁ።',
    ),
  ),
  LearningItem(
    id: 7,
    style: LearningStyle.readingWriting,
    text: LocalizedText(
      en: 'I understand ideas better when I write them down.',
      am: 'ሃሳቦችን ጽፌ ሳስቀምጣቸው በተሻለ እረዳለሁ።',
    ),
  ),
  LearningItem(
    id: 8,
    style: LearningStyle.kinesthetic,
    text: LocalizedText(
      en: 'I understand better when I can practice or try it myself.',
      am: 'ራሴ ሳለማምድ ወይም ስሞክር በተሻለ እረዳለሁ።',
    ),
  ),

  // ── Round 3 ──
  LearningItem(
    id: 9,
    style: LearningStyle.visual,
    text: LocalizedText(
      en: 'I like to picture ideas in my mind to understand them.',
      am: 'ሃሳቦችን ለመረዳት በአእምሮዬ መሳል እወዳለሁ።',
    ),
  ),
  LearningItem(
    id: 10,
    style: LearningStyle.auditory,
    text: LocalizedText(
      en: 'Talking a topic through helps me understand it.',
      am: 'አንድን ርዕስ በንግግር ማብራራት እንዲገባኝ ይረዳኛል።',
    ),
  ),
  LearningItem(
    id: 11,
    style: LearningStyle.readingWriting,
    text: LocalizedText(
      en: 'I prefer instructions and information in written form.',
      am: 'መመሪያዎችንና መረጃን በጽሑፍ መልክ እመርጣለሁ።',
    ),
  ),
  LearningItem(
    id: 12,
    style: LearningStyle.kinesthetic,
    text: LocalizedText(
      en: "I remember things I've physically done more than things I've read.",
      am: 'በተግባር የሠራኋቸውን ነገሮች ካነበብኳቸው በላይ አስታውሳለሁ።',
    ),
  ),

  // ── Round 4 ──
  LearningItem(
    id: 13,
    style: LearningStyle.visual,
    text: LocalizedText(
      en: 'Color-coding and highlighting help me organize what I learn.',
      am: 'በቀለም መለየትና ማድመቅ የተማርኩትን ለማደራጀት ይረዱኛል።',
    ),
  ),
  LearningItem(
    id: 14,
    style: LearningStyle.auditory,
    text: LocalizedText(
      en: 'I often read aloud or repeat things to remember them.',
      am: 'ለማስታወስ ብዙ ጊዜ ጮክ ብዬ አነባለሁ ወይም እደግማለሁ።',
    ),
  ),
  LearningItem(
    id: 15,
    style: LearningStyle.readingWriting,
    text: LocalizedText(
      en: 'Making lists and summaries helps me remember.',
      am: 'ዝርዝሮችንና ማጠቃለያዎችን መስራት ለማስታወስ ይረዳኛል።',
    ),
  ),
  LearningItem(
    id: 16,
    style: LearningStyle.kinesthetic,
    text: LocalizedText(
      en: 'I get restless learning by only sitting and listening.',
      am: 'ተቀምጬ በማዳመጥ ብቻ ስማር እረበሻለሁ።',
    ),
  ),

  // ── Round 5 ──
  LearningItem(
    id: 17,
    style: LearningStyle.visual,
    text: LocalizedText(
      en: 'When someone explains, I wish I could see it drawn out.',
      am: 'አንድ ሰው ሲያብራራ፣ ተስሎ ማየት እመኛለሁ።',
    ),
  ),
  LearningItem(
    id: 18,
    style: LearningStyle.auditory,
    text: LocalizedText(
      en: 'Discussions and podcasts help me learn effectively.',
      am: 'ውይይቶችና ፖድካስቶች በተሻለ እንድማር ይረዱኛል።',
    ),
  ),
  LearningItem(
    id: 19,
    style: LearningStyle.readingWriting,
    text: LocalizedText(
      en: "I'd rather read a manual than watch a demonstration.",
      am: 'ማሳያ ከማየት ይልቅ መመሪያ ማንበብ እመርጣለሁ።',
    ),
  ),
  LearningItem(
    id: 20,
    style: LearningStyle.kinesthetic,
    text: LocalizedText(
      en: 'Real examples and hands-on activities help me grasp ideas.',
      am: 'እውነተኛ ምሳሌዎችና ተግባራዊ እንቅስቃሴዎች ሃሳቦችን እንድጨብጥ ይረዱኛል።',
    ),
  ),
];
