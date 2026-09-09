import 'models/leadership.dart';
import 'models/question.dart';

/// A single Leadership Style item: a first-person statement the user rates by
/// agreement (1 = strongly disagree, 5 = strongly agree).
class LeadershipItem implements TestItem {
  const LeadershipItem({
    required this.id,
    required this.style,
    required this.text,
  });

  @override
  final int id;

  /// Which Goleman leadership style this statement loads onto.
  final LeadershipStyle style;

  @override
  final LocalizedText text;
}

/// The 36 Leadership Style items — 6 statements per Goleman style, interleaved.
/// All positively keyed: each counts toward its own style.
const List<LeadershipItem> kLeadershipItems = <LeadershipItem>[
  // ── Round 1 ──
  LeadershipItem(
    id: 1,
    style: LeadershipStyle.visionary,
    text: LocalizedText(
      en: "I naturally paint a clear, inspiring picture of where we're headed.",
      am: 'ወዴት እያመራን እንደሆነ ግልጽና አነቃቂ ምስል በተፈጥሮ እስላለሁ።',
    ),
  ),
  LeadershipItem(
    id: 2,
    style: LeadershipStyle.coaching,
    text: LocalizedText(
      en: 'I invest time helping people grow their skills.',
      am: 'ሰዎች ክህሎታቸውን እንዲያሳድጉ ለመርዳት ጊዜ እሰጣለሁ።',
    ),
  ),
  LeadershipItem(
    id: 3,
    style: LeadershipStyle.affiliative,
    text: LocalizedText(
      en: 'I put people and relationships first.',
      am: 'ሰዎችንና ግንኙነቶችን አስቀድማለሁ።',
    ),
  ),
  LeadershipItem(
    id: 4,
    style: LeadershipStyle.democratic,
    text: LocalizedText(
      en: 'I make decisions by seeking input from the team.',
      am: 'ከቡድኑ ሐሳብ በመቀበል ውሳኔ አደርጋለሁ።',
    ),
  ),
  LeadershipItem(
    id: 5,
    style: LeadershipStyle.pacesetting,
    text: LocalizedText(
      en: 'I set high performance standards and model them myself.',
      am: 'ከፍተኛ የአፈጻጸም መስፈርት አስቀምጣለሁ በራሴም አሳያለሁ።',
    ),
  ),
  LeadershipItem(
    id: 6,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: 'In a crisis, I take firm control and give clear orders.',
      am: 'በችግር ጊዜ ጠንካራ ቁጥጥር እወስዳለሁ ግልጽ ትዕዛዞችንም እሰጣለሁ።',
    ),
  ),

  // ── Round 2 ──
  LeadershipItem(
    id: 7,
    style: LeadershipStyle.visionary,
    text: LocalizedText(
      en: 'I help people see how their work connects to a bigger purpose.',
      am: 'ሰዎች ሥራቸው ከትልቅ ዓላማ ጋር እንዴት እንደሚገናኝ እንዲያዩ እረዳለሁ።',
    ),
  ),
  LeadershipItem(
    id: 8,
    style: LeadershipStyle.coaching,
    text: LocalizedText(
      en: 'I enjoy mentoring others and giving developmental feedback.',
      am: 'ሌሎችን ማማከርና የእድገት አስተያየት መስጠት ያስደስተኛል።',
    ),
  ),
  LeadershipItem(
    id: 9,
    style: LeadershipStyle.affiliative,
    text: LocalizedText(
      en: 'I work hard to keep the team in harmony.',
      am: 'ቡድኑ በስምምነት እንዲቆይ ጠንክሬ እሠራለሁ።',
    ),
  ),
  LeadershipItem(
    id: 10,
    style: LeadershipStyle.democratic,
    text: LocalizedText(
      en: "I value everyone's voice before choosing a direction.",
      am: 'አቅጣጫ ከመምረጤ በፊት የሁሉንም ድምፅ አከብራለሁ።',
    ),
  ),
  LeadershipItem(
    id: 11,
    style: LeadershipStyle.pacesetting,
    text: LocalizedText(
      en: 'I expect excellence and move quickly to achieve it.',
      am: 'የላቀ ውጤት እጠብቃለሁ ለማሳካትም በፍጥነት እንቀሳቀሳለሁ።',
    ),
  ),
  LeadershipItem(
    id: 12,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: 'I expect people to do what I ask without much debate.',
      am: 'ሰዎች የምጠይቀውን ብዙ ክርክር ሳይኖር እንዲፈጽሙ እጠብቃለሁ።',
    ),
  ),

  // ── Round 3 ──
  LeadershipItem(
    id: 13,
    style: LeadershipStyle.visionary,
    text: LocalizedText(
      en: 'I lead by setting a compelling direction and letting people find '
          'their way.',
      am: 'አሳማኝ አቅጣጫ በማስቀመጥና ሰዎች መንገዳቸውን እንዲያገኙ በመፍቀድ እመራለሁ።',
    ),
  ),
  LeadershipItem(
    id: 14,
    style: LeadershipStyle.coaching,
    text: LocalizedText(
      en: 'I help people identify their strengths and areas to improve.',
      am: 'ሰዎች ጥንካሬያቸውንና ሊያሻሽሉት የሚገባውን እንዲለዩ እረዳለሁ።',
    ),
  ),
  LeadershipItem(
    id: 15,
    style: LeadershipStyle.affiliative,
    text: LocalizedText(
      en: "I pay close attention to people's emotional needs.",
      am: 'ለሰዎች ስሜታዊ ፍላጎት ከፍተኛ ትኩረት እሰጣለሁ።',
    ),
  ),
  LeadershipItem(
    id: 16,
    style: LeadershipStyle.democratic,
    text: LocalizedText(
      en: 'I build buy-in by involving people in decisions.',
      am: 'ሰዎችን በውሳኔ ውስጥ በማሳተፍ ተቀባይነትን እገነባለሁ።',
    ),
  ),
  LeadershipItem(
    id: 17,
    style: LeadershipStyle.pacesetting,
    text: LocalizedText(
      en: 'I lead by personally demonstrating how things should be done.',
      am: 'ነገሮች እንዴት መከናወን እንዳለባቸው በራሴ በማሳየት እመራለሁ።',
    ),
  ),
  LeadershipItem(
    id: 18,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: 'I make quick decisions and direct people decisively.',
      am: 'ፈጣን ውሳኔ አደርጋለሁ ሰዎችንም በቆራጥነት እመራለሁ።',
    ),
  ),

  // ── Round 4 ──
  LeadershipItem(
    id: 19,
    style: LeadershipStyle.visionary,
    text: LocalizedText(
      en: 'I get people excited about a shared long-term goal.',
      am: 'ሰዎችን ስለ የጋራ የረዥም ጊዜ ግብ አነቃቃለሁ።',
    ),
  ),
  LeadershipItem(
    id: 20,
    style: LeadershipStyle.coaching,
    text: LocalizedText(
      en: "I care about people's long-term development, not just today's "
          'results.',
      am: 'ስለ ሰዎች የረዥም ጊዜ እድገት እንጂ ስለ ዛሬ ውጤት ብቻ አላስብም።',
    ),
  ),
  LeadershipItem(
    id: 21,
    style: LeadershipStyle.affiliative,
    text: LocalizedText(
      en: 'I build trust by being supportive and caring.',
      am: 'ደጋፊና አሳቢ በመሆን መተማመንን እገነባለሁ።',
    ),
  ),
  LeadershipItem(
    id: 22,
    style: LeadershipStyle.democratic,
    text: LocalizedText(
      en: 'I trust the group to help find the best path.',
      am: 'ምርጡን መንገድ ለማግኘት ቡድኑን አምናለሁ።',
    ),
  ),
  LeadershipItem(
    id: 23,
    style: LeadershipStyle.pacesetting,
    text: LocalizedText(
      en: 'I push for better, faster results.',
      am: 'የተሻለና ፈጣን ውጤት እንዲመጣ እገፋፋለሁ።',
    ),
  ),
  LeadershipItem(
    id: 24,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: "I'm comfortable being the one clearly in charge.",
      am: 'በግልጽ ኃላፊው መሆን ያመቸኛል።',
    ),
  ),

  // ── Round 5 ──
  LeadershipItem(
    id: 25,
    style: LeadershipStyle.visionary,
    text: LocalizedText(
      en: 'I focus on the "why" behind what we do, not just the "how".',
      am: 'በምንሠራው ነገር ላይ «እንዴት» ብቻ ሳይሆን «ለምን» በሚለው ላይ አተኩራለሁ።',
    ),
  ),
  LeadershipItem(
    id: 26,
    style: LeadershipStyle.coaching,
    text: LocalizedText(
      en: 'I ask questions that help people find their own answers.',
      am: 'ሰዎች የራሳቸውን መልስ እንዲያገኙ የሚረዱ ጥያቄዎችን እጠይቃለሁ።',
    ),
  ),
  LeadershipItem(
    id: 27,
    style: LeadershipStyle.affiliative,
    text: LocalizedText(
      en: 'I resolve conflict by helping people reconnect.',
      am: 'ሰዎች እንደገና እንዲቀራረቡ በመርዳት አለመግባባትን እፈታለሁ።',
    ),
  ),
  LeadershipItem(
    id: 28,
    style: LeadershipStyle.democratic,
    text: LocalizedText(
      en: 'I hold discussions to reach a shared decision.',
      am: 'የጋራ ውሳኔ ላይ ለመድረስ ውይይቶችን አካሂዳለሁ።',
    ),
  ),
  LeadershipItem(
    id: 29,
    style: LeadershipStyle.pacesetting,
    text: LocalizedText(
      en: 'I have little patience for poor performance.',
      am: 'ለደካማ አፈጻጸም ትዕግስት የለኝም።',
    ),
  ),
  LeadershipItem(
    id: 30,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: 'When things go wrong, I step in and take command.',
      am: 'ነገሮች ሲበላሹ ጣልቃ ገብቼ አመራሩን እወስዳለሁ።',
    ),
  ),

  // ── Round 6 ──
  LeadershipItem(
    id: 31,
    style: LeadershipStyle.visionary,
    text: LocalizedText(
      en: "I inspire others by describing what's possible.",
      am: 'ሊሆን የሚችለውን በመግለጽ ሌሎችን አነሳሳለሁ።',
    ),
  ),
  LeadershipItem(
    id: 32,
    style: LeadershipStyle.coaching,
    text: LocalizedText(
      en: 'I delegate challenging tasks to help people stretch and learn.',
      am: 'ሰዎች እንዲፈተኑና እንዲማሩ ከባድ ሥራዎችን አደራለሁ።',
    ),
  ),
  LeadershipItem(
    id: 33,
    style: LeadershipStyle.affiliative,
    text: LocalizedText(
      en: 'I celebrate people and strengthen team bonds.',
      am: 'ሰዎችን አከብራለሁ የቡድኑንም ትስስር አጠናክራለሁ።',
    ),
  ),
  LeadershipItem(
    id: 34,
    style: LeadershipStyle.democratic,
    text: LocalizedText(
      en: 'I ask "what do you think?" before deciding.',
      am: 'ከመወሰኔ በፊት «አንተ ምን ታስባለህ?» እጠይቃለሁ።',
    ),
  ),
  LeadershipItem(
    id: 35,
    style: LeadershipStyle.pacesetting,
    text: LocalizedText(
      en: 'I drive myself and others hard to hit ambitious targets.',
      am: 'ከፍ ያሉ ግቦችን ለመምታት ራሴንም ሌሎችንም አበረታታለሁ።',
    ),
  ),
  LeadershipItem(
    id: 36,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: 'I set the rules and expect them to be followed.',
      am: 'ደንቦችን አስቀምጣለሁ እንዲከበሩም እጠብቃለሁ።',
    ),
  ),
];
