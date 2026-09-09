import 'models/question.dart';
import 'models/riasec.dart';

/// A single Career Aptitude (RIASEC) item: a concrete work activity the user
/// rates from "Strongly Dislike" to "Strongly Like".
class CareerItem implements TestItem {
  const CareerItem({
    required this.id,
    required this.area,
    required this.text,
  });

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
      am: 'የወጥ ቤት ቁምሳጥኖችን መስራት',
    ),
  ),
  CareerItem(
    id: 2,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Study the structure of the human body',
      am: 'የሰውነት አካል አወቃቀርን ማጥናት',
    ),
  ),
  CareerItem(
    id: 3,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Write books or plays',
      am: 'መጽሐፍት ወይም ተውኔቶችን መጻፍ',
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
    text: LocalizedText(
      en: 'Start your own business',
      am: 'የራስን ንግድ መጀመር',
    ),
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
    text: LocalizedText(
      en: 'Develop a new medicine',
      am: 'አዲስ መድኃኒት ማበልጸግ',
    ),
  ),
  CareerItem(
    id: 9,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Play a musical instrument',
      am: 'የሙዚቃ መሣሪያ መጫወት',
    ),
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
    text: LocalizedText(
      en: 'Manage a retail store',
      am: 'የችርቻሮ መደብር ማስተዳደር',
    ),
  ),
  CareerItem(
    id: 12,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Develop a spreadsheet to track expenses',
      am: 'ወጪዎችን ለመከታተል ሠንጠረዥ (ስፕሬድሺት) ማዘጋጀት',
    ),
  ),

  // ── Round 3 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 13,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Drive a truck to deliver packages',
      am: 'ጭነት ለማድረስ የጭነት መኪና መንዳት',
    ),
  ),
  CareerItem(
    id: 14,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Conduct chemical experiments',
      am: 'የኬሚስትሪ ሙከራዎችን ማካሄድ',
    ),
  ),
  CareerItem(
    id: 15,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Design artwork for magazines',
      am: 'ለመጽሔቶች የሥዕል ጥበብ ንድፍ መስራት',
    ),
  ),
  CareerItem(
    id: 16,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Give career guidance to people',
      am: 'ለሰዎች የሙያ ምክር መስጠት',
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
      am: 'የድርጅት የደመወዝ ክፍያ ማስላት',
    ),
  ),

  // ── Round 4 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 19,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Assemble electronic parts',
      am: 'የኤሌክትሮኒክስ ክፍሎችን መገጣጠም',
    ),
  ),
  CareerItem(
    id: 20,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Study ways to reduce water pollution',
      am: 'የውሃ ብክለትን ለመቀነስ መንገዶችን ማጥናት',
    ),
  ),
  CareerItem(
    id: 21,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Compose or arrange music',
      am: 'ሙዚቃ መድረስ ወይም ማቀናበር',
    ),
  ),
  CareerItem(
    id: 22,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Take care of children at a day-care center',
      am: 'በማዋያ ተቋም ውስጥ ልጆችን መንከባከብ',
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
      am: 'የንግድ መዝገቦችን ማደራጀትና መመዝገብ',
    ),
  ),

  // ── Round 5 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 25,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Install flooring in houses',
      am: 'በቤቶች ውስጥ የወለል ንጣፍ መግጠም',
    ),
  ),
  CareerItem(
    id: 26,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Investigate the cause of a disease',
      am: 'የበሽታ መንስኤን መመርመር',
    ),
  ),
  CareerItem(
    id: 27,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Draw pictures or paint',
      am: 'ሥዕል መሳል ወይም ቀለም መቀባት',
    ),
  ),
  CareerItem(
    id: 28,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Help people who have problems with drugs or alcohol',
      am: 'በዕፅ ወይም በአልኮል ችግር ውስጥ ያሉ ሰዎችን መርዳት',
    ),
  ),
  CareerItem(
    id: 29,
    area: RiasecArea.enterprising,
    text: LocalizedText(
      en: 'Market a new product',
      am: 'አዲስ ምርትን ማስተዋወቅ',
    ),
  ),
  CareerItem(
    id: 30,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Proofread records or forms',
      am: 'መዝገቦችን ወይም ቅጾችን ማረም',
    ),
  ),

  // ── Round 6 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 31,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Fix a broken engine',
      am: 'የተበላሸ ሞተር መጠገን',
    ),
  ),
  CareerItem(
    id: 32,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Do research on plants or animals',
      am: 'ስለ ዕፅዋት ወይም እንስሳት ምርምር ማድረግ',
    ),
  ),
  CareerItem(
    id: 33,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Act in a play',
      am: 'በተውኔት ውስጥ መተወን',
    ),
  ),
  CareerItem(
    id: 34,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Teach an exercise or fitness class',
      am: 'የአካል ብቃት እንቅስቃሴ ትምህርት ማስተማር',
    ),
  ),
  CareerItem(
    id: 35,
    area: RiasecArea.enterprising,
    text: LocalizedText(
      en: 'Manage a department within a large company',
      am: 'በትልቅ ድርጅት ውስጥ አንድ ክፍልን ማስተዳደር',
    ),
  ),
  CareerItem(
    id: 36,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Handle a business office’s bookkeeping',
      am: 'የንግድ ቢሮ የሂሳብ መዝገብ ሥራን ማከናወን',
    ),
  ),

  // ── Round 7 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 37,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Operate a machine on a production line',
      am: 'በማምረቻ መስመር ላይ ማሽን ማንቀሳቀስ',
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
      am: 'ለፊልም ወይም ለቴሌቪዥን ድርሰት መጻፍ',
    ),
  ),
  CareerItem(
    id: 40,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Assist doctors in treating patients',
      am: 'ሐኪሞችን በሽተኞችን በማከም ማገዝ',
    ),
  ),
  CareerItem(
    id: 41,
    area: RiasecArea.enterprising,
    text: LocalizedText(
      en: 'Buy and sell stocks and bonds',
      am: 'የአክሲዮንና የቦንድ ግዢና ሽያጭ ማከናወን',
    ),
  ),
  CareerItem(
    id: 42,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Inventory supplies using a hand-held computer',
      am: 'በእጅ በሚያዝ ኮምፒውተር ዕቃዎችን መቁጠርና መመዝገብ',
    ),
  ),

  // ── Round 8 ──────────────────────────────────────────────────────────────
  CareerItem(
    id: 43,
    area: RiasecArea.realistic,
    text: LocalizedText(
      en: 'Lay brick or tile',
      am: 'ጡብ ወይም ንጣፍ (ታይል) መንጠፍ',
    ),
  ),
  CareerItem(
    id: 44,
    area: RiasecArea.investigative,
    text: LocalizedText(
      en: 'Work in a science laboratory',
      am: 'በሳይንስ ላቦራቶሪ ውስጥ መስራት',
    ),
  ),
  CareerItem(
    id: 45,
    area: RiasecArea.artistic,
    text: LocalizedText(
      en: 'Create special effects for movies',
      am: 'ለፊልሞች ልዩ ዕይታዎችን (ስፔሻል ኢፌክት) መፍጠር',
    ),
  ),
  CareerItem(
    id: 46,
    area: RiasecArea.social,
    text: LocalizedText(
      en: 'Teach a high-school class',
      am: 'የሁለተኛ ደረጃ ትምህርት ማስተማር',
    ),
  ),
  CareerItem(
    id: 47,
    area: RiasecArea.enterprising,
    text: LocalizedText(
      en: 'Give a speech to persuade a group of people',
      am: 'የሰዎችን ስብስብ ለማሳመን ንግግር ማድረግ',
    ),
  ),
  CareerItem(
    id: 48,
    area: RiasecArea.conventional,
    text: LocalizedText(
      en: 'Stamp, sort, and distribute mail for an organization',
      am: 'ለድርጅት ደብዳቤዎችን ማህተም ማድረግ፣ መለየትና ማከፋፈል',
    ),
  ),
];
