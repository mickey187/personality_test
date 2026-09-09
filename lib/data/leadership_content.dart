import 'models/leadership.dart';
import 'models/question.dart';
import 'ranked_content.dart';

/// Description + a practical tip per Goleman leadership style, EN and AM.
const Map<LeadershipStyle, RankedContent> kLeadershipContent =
    <LeadershipStyle, RankedContent>{
  LeadershipStyle.visionary: RankedContent(
    description: LocalizedText(
      en: 'You lead by inspiring people with a clear, compelling vision — you '
          'set direction and let people find their own way there.',
      am: 'ግልጽና አሳማኝ ራዕይ በማቅረብ ሰዎችን በማነሳሳት ትመራለህ — አቅጣጫ ታስቀምጣለህ ሰዎችም መንገዳቸውን '
          'እንዲያገኙ ትፈቅዳለህ።',
    ),
    tip: LocalizedText(
      en: 'Best when the team needs a fresh direction; pair it with listening '
          'so the vision feels shared, not imposed.',
      am: 'ቡድኑ አዲስ አቅጣጫ ሲፈልግ በጣም ይሠራል፤ ራዕዩ የተጫነ ሳይሆን የጋራ እንዲመስል ከማዳመጥ ጋር አጣምረው።',
    ),
  ),
  LeadershipStyle.coaching: RankedContent(
    description: LocalizedText(
      en: 'You lead by developing people — mentoring, giving feedback, and '
          'helping others grow toward their potential.',
      am: 'ሰዎችን በማሳደግ ትመራለህ — በማማከር፣ አስተያየት በመስጠትና ሌሎች አቅማቸው ላይ እንዲደርሱ በመርዳት።',
    ),
    tip: LocalizedText(
      en: 'Powerful for long-term growth; make time for it even when short-term '
          'pressure is high.',
      am: 'ለረዥም ጊዜ እድገት ኃይለኛ ነው፤ የአጭር ጊዜ ጫና ቢኖርም ለእሱ ጊዜ ስጥ።',
    ),
  ),
  LeadershipStyle.affiliative: RankedContent(
    description: LocalizedText(
      en: 'You lead by building harmony and strong relationships — people feel '
          'cared for and connected under you.',
      am: 'ስምምነትንና ጠንካራ ግንኙነቶችን በመገንባት ትመራለህ — በአንተ ሥር ሰዎች እንክብካቤና መቀራረብ ይሰማቸዋል።',
    ),
    tip: LocalizedText(
      en: 'Great for healing rifts and building trust; balance it with honest '
          'feedback so standards stay high.',
      am: 'ስንጥቆችን ለመጠገንና መተማመንን ለመገንባት ጥሩ ነው፤ መስፈርቶች ከፍ ብለው እንዲቆዩ ከግልጽ አስተያየት ጋር '
          'አመዛዝነው።',
    ),
  ),
  LeadershipStyle.democratic: RankedContent(
    description: LocalizedText(
      en: "You lead by building consensus — you value everyone's input and "
          'forge decisions the whole team supports.',
      am: 'መግባባትን በመገንባት ትመራለህ — የሁሉንም ሐሳብ ታከብራለህ ቡድኑ ሙሉ በሙሉ የሚደግፈውንም ውሳኔ ትፈጥራለህ።',
    ),
    tip: LocalizedText(
      en: 'Ideal when you need buy-in; in a true crisis, be ready to decide '
          'quickly rather than keep debating.',
      am: 'ተቀባይነት ሲያስፈልግ ተስማሚ ነው፤ በእውነተኛ ችግር ጊዜ ግን ከመከራከር ይልቅ በፍጥነት ለመወሰን ተዘጋጅ።',
    ),
  ),
  LeadershipStyle.pacesetting: RankedContent(
    description: LocalizedText(
      en: 'You lead by example with high standards — you set an ambitious pace '
          'and expect excellence.',
      am: 'በከፍተኛ መስፈርት በምሳሌ ትመራለህ — ከፍ ያለ ፍጥነት ታስቀምጣለህ የላቀ ውጤትም ትጠብቃለህ።',
    ),
    tip: LocalizedText(
      en: 'Effective with a skilled, motivated team; used too much it can '
          'overwhelm people, so dial it back at times.',
      am: 'ከተካነና ከተነሳሳ ቡድን ጋር ውጤታማ ነው፤ ከመጠን በላይ ሲሆን ሰዎችን ሊያደክም ስለሚችል አልፎ አልፎ አቀዝቅዘው።',
    ),
  ),
  LeadershipStyle.commanding: RankedContent(
    description: LocalizedText(
      en: 'You lead with clear, decisive authority — in a crisis you take '
          'charge and give firm direction.',
      am: 'በግልጽና በቆራጥ ስልጣን ትመራለህ — በችግር ጊዜ አመራሩን ወስደህ ጠንካራ አቅጣጫ ትሰጣለህ።',
    ),
    tip: LocalizedText(
      en: 'Vital in emergencies and turnarounds; use it sparingly, as constant '
          'command can erode morale.',
      am: 'በአደጋና በለውጥ ጊዜ አስፈላጊ ነው፤ ዘወትር ማዘዝ ሞራልን ሊሸረሽር ስለሚችል በጥንቃቄ ተጠቀምበት።',
    ),
  ),
};
