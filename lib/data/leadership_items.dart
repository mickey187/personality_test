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
      am: 'ወዴት እያመራን እንደሆነ ግልጽ እና አነቃቂ የሆነ ምስልን በተፈጥሮዬ አስቀምጣለሁ።',
    ),
  ),
  LeadershipItem(
    id: 2,
    style: LeadershipStyle.coaching,
    text: LocalizedText(
      en: 'I invest time helping people grow their skills.',
      am: 'ሰዎች ክህሎታቸውን እንዲያሳድጉ ለመርዳት ጊዜዬን እሰጣለሁ።',
    ),
  ),
  LeadershipItem(
    id: 3,
    style: LeadershipStyle.affiliative,
    text: LocalizedText(
      en: 'I put people and relationships first.',
      am: 'ለሰዎች እና ለግንኙነቶች ቅድሚያ እሰጣለሁ።',
    ),
  ),
  LeadershipItem(
    id: 4,
    style: LeadershipStyle.democratic,
    text: LocalizedText(
      en: 'I make decisions by seeking input from the team.',
      am: 'ውሳኔዎችን የምወስነው ከቡድኑ ሀሳብ በመቀበል ነው።',
    ),
  ),
  LeadershipItem(
    id: 5,
    style: LeadershipStyle.pacesetting,
    text: LocalizedText(
      en: 'I set high performance standards and model them myself.',
      am: 'ከፍተኛ የሥራ አፈጻጸም ደረጃዎችን አስቀምጣለሁ፤ እኔም ራሴ አርአያ እሆናለሁ።',
    ),
  ),
  LeadershipItem(
    id: 6,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: 'In a crisis, I take firm control and give clear orders.',
      am: 'ቀውስ ሲፈጠር ሁኔታውን ተቆጣጥሬ ግልጽ ትዕዛዞችን እሰጣለሁ።',
    ),
  ),

  // ── Round 2 ──
  LeadershipItem(
    id: 7,
    style: LeadershipStyle.visionary,
    text: LocalizedText(
      en: 'I help people see how their work connects to a bigger purpose.',
      am: 'ሰዎች ሥራቸው ከትልቁ ዓላማ ጋር እንዴት እንደሚገናኝ እንዲገነዘቡ እረዳለሁ።',
    ),
  ),
  LeadershipItem(
    id: 8,
    style: LeadershipStyle.coaching,
    text: LocalizedText(
      en: 'I enjoy mentoring others and giving developmental feedback.',
      am: 'ሌሎችን መምከር እና እድገታቸው ላይ ያተኮረ ገንቢ አስተያየት መስጠት ያስደስተኛል።',
    ),
  ),
  LeadershipItem(
    id: 9,
    style: LeadershipStyle.affiliative,
    text: LocalizedText(
      en: 'I work hard to keep the team in harmony.',
      am: 'የቡድኑን ስምምነት እና ሰላም ለመጠበቅ ጠንክሬ እሰራለሁ።',
    ),
  ),
  LeadershipItem(
    id: 10,
    style: LeadershipStyle.democratic,
    text: LocalizedText(
      en: "I value everyone's voice before choosing a direction.",
      am: 'አቅጣጫ ከመምረጤ በፊት የሁሉንም ሰው ሀሳብ ከፍ አድርጌ እመለከታለሁ።',
    ),
  ),
  LeadershipItem(
    id: 11,
    style: LeadershipStyle.pacesetting,
    text: LocalizedText(
      en: 'I expect excellence and move quickly to achieve it.',
      am: 'የላቀ ውጤት እጠብቃለሁ፤ እሱን ለማሳካትም በፍጥነት እነቀሳቀሳለሁ።',
    ),
  ),
  LeadershipItem(
    id: 12,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: 'I expect people to do what I ask without much debate.',
      am: 'ሰዎች ያልኳቸውን ነገር ብዙ ውይይት ሳያደርጉ እንዲፈጽሙ እጠብቃለሁ።',
    ),
  ),

  // ── Round 3 ──
  LeadershipItem(
    id: 13,
    style: LeadershipStyle.visionary,
    text: LocalizedText(
      en:
          'I lead by setting a compelling direction and letting people find '
          'their way.',
      am: 'አጓጊ አቅጣጫ አስቀምጬ ሰዎች የራሳቸውን መንገድ እንዲያገኙ በመተው እመራለሁ።',
    ),
  ),
  LeadershipItem(
    id: 14,
    style: LeadershipStyle.coaching,
    text: LocalizedText(
      en: 'I help people identify their strengths and areas to improve.',
      am: 'ሰዎች ጠንካራ ጎናቸውን እና ሊያሻሽሏቸው የሚገቡ ነገሮችን እንዲለዩ እረዳቸዋለሁ።',
    ),
  ),
  LeadershipItem(
    id: 15,
    style: LeadershipStyle.affiliative,
    text: LocalizedText(
      en: "I pay close attention to people's emotional needs.",
      am: 'ለሰዎች ስሜታዊ ፍላጎቶች ከፍተኛ ትኩረት እሰጣለሁ።',
    ),
  ),
  LeadershipItem(
    id: 16,
    style: LeadershipStyle.democratic,
    text: LocalizedText(
      en: 'I build buy-in by involving people in decisions.',
      am: 'ሰዎችን በውሳኔ አሰጣጥ ሂደት ውስጥ በማሳተፍ የጋራ ስምምነትን እገነባለሁ።',
    ),
  ),
  LeadershipItem(
    id: 17,
    style: LeadershipStyle.pacesetting,
    text: LocalizedText(
      en: 'I lead by personally demonstrating how things should be done.',
      am: 'ነገሮች እንዴት መከናወን እንዳለባቸው እኔ ራሴ በተግባር በማሳየት እመራለሁ።',
    ),
  ),
  LeadershipItem(
    id: 18,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: 'I make quick decisions and direct people decisively.',
      am: 'ፈጣን ውሳኔዎችን ወስኜ ሰዎችን በቆራጥነት እመራለሁ።',
    ),
  ),

  // ── Round 4 ──
  LeadershipItem(
    id: 19,
    style: LeadershipStyle.visionary,
    text: LocalizedText(
      en: 'I get people excited about a shared long-term goal.',
      am: 'ሰዎችን በጋራ የረጅም ጊዜ ግባችን ላይ እንዲነሳሱ አደርጋለሁ።',
    ),
  ),
  LeadershipItem(
    id: 20,
    style: LeadershipStyle.coaching,
    text: LocalizedText(
      en:
          "I care about people's long-term development, not just today's "
          'results.',
      am: 'ስለዛሬው ውጤት ብቻ ሳይሆን ስለ ሰዎች የረጅም ጊዜ እድገትም አስባለሁ።',
    ),
  ),
  LeadershipItem(
    id: 21,
    style: LeadershipStyle.affiliative,
    text: LocalizedText(
      en: 'I build trust by being supportive and caring.',
      am: 'ደጋፊ እና አሳቢ በመሆን በሰዎች ዘንድ መተማመንን እገነባለሁ።',
    ),
  ),
  LeadershipItem(
    id: 22,
    style: LeadershipStyle.democratic,
    text: LocalizedText(
      en: 'I trust the group to help find the best path.',
      am: 'የተሻለውን መንገድ ለማግኘት በቡድኑ እተማመናለሁ።',
    ),
  ),
  LeadershipItem(
    id: 23,
    style: LeadershipStyle.pacesetting,
    text: LocalizedText(
      en: 'I push for better, faster results.',
      am: 'ለተሻለ እና ለፈጣን ውጤት እገፋፋለሁ።',
    ),
  ),
  LeadershipItem(
    id: 24,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: "I'm comfortable being the one clearly in charge.",
      am: 'በግልጽ ኃላፊነቱን መውሰድ አይከብደኝም።',
    ),
  ),

  // ── Round 5 ──
  LeadershipItem(
    id: 25,
    style: LeadershipStyle.visionary,
    text: LocalizedText(
      en: 'I focus on the "why" behind what we do, not just the "how".',
      am: 'አንድን ነገር \'እንዴት\' እንደምንሰራው ላይ ብቻ ሳይሆን \'ለምን\' እንደምንሰራው ላይ ትኩረት አደርጋለሁ።',
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
      am: 'ሰዎች እንደገና እንዲግባቡ በመርዳት ግጭትን እፈታለሁ።',
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
      am: 'ለደካማ የሥራ አፈጻጸም ብዙ ትዕግስት የለኝም።',
    ),
  ),
  LeadershipItem(
    id: 30,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: 'When things go wrong, I step in and take command.',
      am: 'ነገሮች ሲበላሹ ጣልቃ ገብቼ ሁኔታውን እቆጣጠራለሁ።',
    ),
  ),

  // ── Round 6 ──
  LeadershipItem(
    id: 31,
    style: LeadershipStyle.visionary,
    text: LocalizedText(
      en: "I inspire others by describing what's possible.",
      am: 'ሊሆኑ የሚችሉ ነገሮችን በመግለጽ ሌሎችን አነሳሳለሁ።',
    ),
  ),
  LeadershipItem(
    id: 32,
    style: LeadershipStyle.coaching,
    text: LocalizedText(
      en: 'I delegate challenging tasks to help people stretch and learn.',
      am: 'ሰዎች አቅማቸውን እንዲፈትኑ እና እንዲማሩ ለመርዳት ፈታኝ ሥራዎችን አሳልፌ እሰጣለሁ።',
    ),
  ),
  LeadershipItem(
    id: 33,
    style: LeadershipStyle.affiliative,
    text: LocalizedText(
      en: 'I celebrate people and strengthen team bonds.',
      am: 'የሰዎችን ስኬት አከብራለሁ፤ የቡድን ትስስርንም አጠናክራለሁ።',
    ),
  ),
  LeadershipItem(
    id: 34,
    style: LeadershipStyle.democratic,
    text: LocalizedText(
      en: 'I ask "what do you think?" before deciding.',
      am: 'ከመወሰኔ በፊት “ምን ታስባላችሁ?” ብዬ እጠይቃለሁ።',
    ),
  ),
  LeadershipItem(
    id: 35,
    style: LeadershipStyle.pacesetting,
    text: LocalizedText(
      en: 'I drive myself and others hard to hit ambitious targets.',
      am: 'ከፍ ያሉ ግቦችን ለመምታት እራሴንም ሆነ ሌሎችን ጠንክሬ እገፋለሁ።',
    ),
  ),
  LeadershipItem(
    id: 36,
    style: LeadershipStyle.commanding,
    text: LocalizedText(
      en: 'I set the rules and expect them to be followed.',
      am: 'ደንቦችን አወጣለሁ፤ እንዲከበሩም እጠብቃለሁ።',
    ),
  ),
];
