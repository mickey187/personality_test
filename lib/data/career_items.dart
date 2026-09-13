import 'models/question.dart';
import 'models/riasec.dart';

/// A single Career Aptitude (RIASEC) item: a concrete work activity the user
/// rates from "Strongly Dislike" to "Strongly Like".
class CareerItem implements TestItem {
  const CareerItem({required this.id, required this.area, required this.text});

  /// 1-based presentation number (only a key — order does not affect scoring).
  @override
  final int id;

  /// Which RIASEC interest area this activity loads onto.
  final RiasecArea area;

  /// The work-activity statement shown to the user, in each supported language.
  @override
  final LocalizedText text;
}

/// The 48 Career Aptitude items — 8 work activities per RIASEC area.
///
/// Activity statements are adapted from the O*NET Interest Profiler Short Form
/// (National Center for O*NET Development, U.S. Department of Labor), licensed
/// CC BY 4.0. All items are positively keyed (no reverse scoring): each simply
/// counts toward its own interest area.
///
/// Presentation order (ids 1–48) interleaves the six areas so no run of similar
/// activities appears back to back. The id is only a key, so the order does not
/// affect scoring — [CareerItem.area] does.
const List<CareerItem> kCareerItems = <CareerItem>[
  // ── Round 1 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 1,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Build kitchen cabinets',
      am: 'የወጥ ቤት ካቢኔቶችን መገንባት',
    ),
  ),
  CareerItem(
    id: 2,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Study the structure of the human body',
      am: 'የሰውነትን አወቃቀር ማጥናት',
    ),
  ),
  CareerItem(
    id: 3,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Write books or plays',
      am: 'መጽሐፍትን ወይም ተውኔቶችን መጻፍ',
    ),
  ),
  CareerItem(
    id: 4,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Teach children how to read',
      am: 'ልጆችን ማንበብ ማስተማር',
    ),
  ),
  CareerItem(
    id: 5,
    area: RiasecArea.enterprising,
    text: LocalizedText(en: 'Start your own business', am: 'የራስን ንግድ መጀመር'),
  ),
  CareerItem(
    id: 6,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Keep shipping and receiving records',
      am: 'የዕቃ መላኪያና መቀበያ መዝገቦችን መያዝ',
    ),
  ),

  // ── Round 2 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 7,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Repair household appliances',
      am: 'የቤት ውስጥ የኤሌክትሪክ ዕቃዎችን መጠገን',
    ),
  ),
  CareerItem(
    id: 8,
    area: RiasecArea.investigative,
    text: LocalizedText(en: 'Develop a new medicine', am: 'አዲስ መድኃኒት ማበልጸግ'),
  ),
  CareerItem(
    id: 9,
    area: RiasecArea.artistic,
    text: LocalizedText(en: 'Play a musical instrument', am: 'የሙዚቃ መሣሪያ መጫወት'),
  ),
  CareerItem(
    id: 10,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Help people with personal or emotional problems',
      am: 'የግል ወይም የስሜት ችግር ያለባቸውን ሰዎች መርዳት',
    ),
  ),
  CareerItem(
    id: 11,
    area: RiasecArea.enterprising,
    text: LocalizedText(en: 'Manage a retail store', am: 'የችርቻሮ መደብርን ማስተዳደር'),
  ),
  CareerItem(
    id: 12,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Develop a spreadsheet to track expenses',
      am: 'ወጪዎችን ለመከታተል ስፕሬድሽት ማዘጋጀት',
    ),
  ),

  // ── Round 3 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 13,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Drive a truck to deliver packages',
      am: 'ጥቅሎችን ለማድረስ የጭነት መኪና መንዳት',
    ),
  ),
  CareerItem(
    id: 14,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Conduct chemical experiments',
      am: 'የኬሚካል ሙከራዎችን ማካሄድ',
    ),
  ),
  CareerItem(
    id: 15,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Design artwork for magazines',
      am: 'ለመጽሔቶች የሥነ-ጥበብ ሥራዎችን መንደፍ',
    ),
  ),
  CareerItem(
    id: 16,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Give career guidance to people',
      am: 'ለሰዎች የሙያ መመሪያ መስጠት',
    ),
  ),
  CareerItem(
    id: 17,
    area: RiasecArea.enterprising,
    text: LocalizedText(
      en: 'Sell products to customers',
      am: 'ምርቶችን ለደንበኞች መሸጥ',
    ),
  ),
  CareerItem(
    id: 18,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: "Calculate a company's payroll",
      am: 'የአንድን ኩባንያ የደመወዝ ክፍያ ማስላት',
    ),
  ),

  // ── Round 4 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 19,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Assemble electronic parts',
      am: 'የኤሌክትሮኒክስ አካላትን መገጣጠም',
    ),
  ),
  CareerItem(
    id: 20,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Study ways to reduce water pollution',
      am: 'የውኃ ብክለትን የሚቀንሱ መንገዶችን ማጥናት',
    ),
  ),
  CareerItem(
    id: 21,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Compose or arrange music',
      am: 'ሙዚቃን መድረስ ወይም ማቀናበር',
    ),
  ),
  CareerItem(
    id: 22,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Take care of children at a day-care center',
      am: 'በሕጻናት ማቆያ ውስጥ ልጆችን መንከባከብ',
    ),
  ),
  CareerItem(
    id: 23,
    area: RiasecArea.enterprising,
    text: LocalizedText(
      en: 'Negotiate business contracts',
      am: 'የንግድ ውሎችን መደራደር',
    ),
  ),
  CareerItem(
    id: 24,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Organize and file business records',
      am: 'የንግድ መዝገቦችን ማደራጀትና በፋይል ማስቀመጥ',
    ),
  ),

  // ── Round 5 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 25,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Install flooring in houses',
      am: 'በቤቶች ውስጥ ወለል ማንጠፍ',
    ),
  ),
  CareerItem(
    id: 26,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Investigate the cause of a disease',
      am: 'የበሽታን መንስኤ መመርመር',
    ),
  ),
  CareerItem(
    id: 27,
    area: RiasecArea.artistic,
    text: LocalizedText(en: 'Draw pictures or paint', am: 'ስዕሎችን መሳል ወይም መቀባት'),
  ),
  CareerItem(
    id: 28,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Help people who have problems with drugs or alcohol',
      am: 'በአደንዛዥ ዕፅ ወይም በአልኮል ችግር ያለባቸውን ሰዎች መርዳት',
    ),
  ),
  CareerItem(
    id: 29,
    area: RiasecArea.enterprising,
    text: LocalizedText(en: 'Market a new product', am: 'አዲስ ምርትን ለገበያ ማቅረብ'),
  ),
  CareerItem(
    id: 30,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Proofread records or forms',
      am: 'መዝገቦችን ወይም ቅጾችን አመሳክሮ ማረም',
    ),
  ),

  // ── Round 6 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 31,
    area: RiasecArea.realistic,
    text: LocalizedText(en: 'Fix a broken engine', am: 'የተበላሸ ሞተርን መጠገን'),
  ),
  CareerItem(
    id: 32,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Do research on plants or animals',
      am: 'በእጽዋት ወይም በእንስሳት ላይ ምርምር ማድረግ',
    ),
  ),
  CareerItem(
    id: 33,
    area: RiasecArea.artistic,
    text: LocalizedText(en: 'Act in a play', am: 'በተውኔት ላይ መተወን'),
  ),
  CareerItem(
    id: 34,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Teach an exercise or fitness class',
      am: 'የአካል ብቃት እንቅስቃሴ ትምህርት መስጠት',
    ),
  ),
  CareerItem(
    id: 35,
    area: RiasecArea.enterprising,
    text: LocalizedText(
      en: 'Manage a department within a large company',
      am: 'በትልቅ ኩባንያ ውስጥ ያለን ክፍል ማስተዳደር',
    ),
  ),
  CareerItem(
    id: 36,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Handle a business office’s bookkeeping',
      am: 'የአንድን ቢሮ የሒሳብ መዝገብ መያዝ',
    ),
  ),

  // ── Round 7 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 37,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Operate a machine on a production line',
      am: 'በማምረቻ መስመር ላይ ማሽንን ማንቀሳቀስ',
    ),
  ),
  CareerItem(
    id: 38,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Study the movement of the planets',
      am: 'የፕላኔቶችን እንቅስቃሴ ማጥናት',
    ),
  ),
  CareerItem(
    id: 39,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Write scripts for movies or television',
      am: 'ለፊልሞች ወይም ለቴሌቪዥን ድርሰት መጻፍ',
    ),
  ),
  CareerItem(
    id: 40,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Assist doctors in treating patients',
      am: 'ሐኪሞችን በሕክምና ወቅት ማገዝ',
    ),
  ),
  CareerItem(
    id: 41,
    area: RiasecArea.enterprising,
    text: LocalizedText(
      en: 'Buy and sell stocks and bonds',
      am: 'አክሲዮኖችንና ቦንዶችን መግዛትና መሸጥ',
    ),
  ),
  CareerItem(
    id: 42,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Inventory supplies using a hand-held computer',
      am: 'በእጅ በሚያዝ ኮምፒውተር የዕቃ ቆጠራ ማድረግ',
    ),
  ),

  // ── Round 8 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 43,
    area: RiasecArea.realistic,
    text: LocalizedText(en: 'Lay brick or tile', am: 'ጡብ ወይም ንጣፍ ማንጠፍ'),
  ),
  CareerItem(
    id: 44,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Work in a science laboratory',
      am: 'በሳይንስ ላብራቶሪ ውስጥ መሥራት',
    ),
  ),
  CareerItem(
    id: 45,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Create special effects for movies',
      am: 'ለፊልሞች \'ስፔሻል ኢፌክት\' መፍጠር',
    ),
  ),
  CareerItem(
    id: 46,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Teach a high-school class',
      am: 'በሁለተኛ ደረጃ ትምህርት ቤት ማስተማር',
    ),
  ),
  CareerItem(
    id: 47,
    area: RiasecArea.enterprising,
    text: LocalizedText(
      en: 'Give a speech to persuade a group of people',
      am: 'አንድን ቡድን ለማሳመን ንግግር ማድረግ',
    ),
  ),
  CareerItem(
    id: 48,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Stamp, sort, and distribute mail for an organization',
      am: 'ለአንድ ድርጅት ፖስታዎችን ማተም፣ መለየትና ማከፋፈል',
    ),
  ),
];
