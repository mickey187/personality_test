import 'models/question.dart';
import 'models/riasec.dart';

/// A curated occupation suggestion for a RIASEC area: a localized job [name]
/// and a one-line [blurb] describing it.
class CareerMatch {
  const CareerMatch({required this.name, required this.blurb});

  final LocalizedText name;
  final LocalizedText blurb;
}

/// One short, self-insight-framed description per RIASEC interest area, shown
/// on the results screen for the user's strongest areas. English and Amharic.
const Map<RiasecArea, LocalizedText> kCareerAreaContent =
    <RiasecArea, LocalizedText>{
  RiasecArea.realistic: LocalizedText(
    en: 'You like hands-on work with tools, machines, plants or animals, and '
        'enjoy seeing tangible results.',
    am: 'በመሣሪያዎች፣ በማሽኖች፣ በዕፅዋት ወይም በእንስሳት ላይ በተግባር መስራት ይወዳሉ፤ ተጨባጭ ውጤት ማየትም '
        'ያስደስትዎታል።',
  ),
  RiasecArea.investigative: LocalizedText(
    en: 'You like to observe, research and solve problems, and enjoy working '
        'with ideas and figuring out how things work.',
    am: 'መመልከት፣ መመራመርና ችግሮችን መፍታት ይወዳሉ፤ በሃሳቦች መስራትና ነገሮች እንዴት እንደሚሠሩ ማወቅም '
        'ያስደስትዎታል።',
  ),
  RiasecArea.artistic: LocalizedText(
    en: 'You like creative, expressive work and value imagination, originality '
        'and freedom from strict routines.',
    am: 'ፈጠራዊና ስሜት ገላጭ ሥራ ይወዳሉ፤ ምናብን፣ አዲስነትንና ከጥብቅ አሠራር ነጻ መሆንን ያከብራሉ።',
  ),
  RiasecArea.social: LocalizedText(
    en: 'You like helping, teaching and working with people, and find meaning '
        'in supporting others’ growth and wellbeing.',
    am: 'ሰዎችን መርዳት፣ ማስተማርና ከሰዎች ጋር መስራት ይወዳሉ፤ የሌሎችን እድገትና ደኅንነት በመደገፍ ትርጉም '
        'ያገኛሉ።',
  ),
  RiasecArea.enterprising: LocalizedText(
    en: 'You like leading, persuading and taking initiative, and enjoy '
        'starting projects and influencing decisions.',
    am: 'መምራት፣ ማሳመንና ተነሳሽነት መውሰድ ይወዳሉ፤ ፕሮጀክቶችን መጀመርና በውሳኔዎች ላይ ተጽዕኖ ማሳደር '
        'ያስደስትዎታል።',
  ),
  RiasecArea.conventional: LocalizedText(
    en: 'You like organized, detail-oriented work with clear procedures, data '
        'and records, and value accuracy and order.',
    am: 'በግልጽ አሠራር፣ በመረጃና በመዝገቦች ላይ የተመሠረተ ሥርዓታማና ዝርዝርን የሚከታተል ሥራ ይወዳሉ፤ '
        'ትክክለኛነትንና ሥርዓትን ያከብራሉ።',
  ),
};

/// Curated occupation suggestions per RIASEC area, sourced from O*NET's
/// by-interest occupation lists (U.S. Dept. of Labor, CC BY 4.0). The results
/// screen shows matches drawn from the user's strongest areas.
const Map<RiasecArea, List<CareerMatch>> kCareerMatches =
    <RiasecArea, List<CareerMatch>>{
  RiasecArea.realistic: <CareerMatch>[
    CareerMatch(
      name: LocalizedText(en: 'Electrician', am: 'ኤሌክትሪሽያን'),
      blurb: LocalizedText(
        en: 'Install and repair electrical systems.',
        am: 'የኤሌክትሪክ ስርዓቶችን መግጠምና መጠገን።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Mechanic', am: 'መካኒክ'),
      blurb: LocalizedText(
        en: 'Diagnose and fix vehicles and machines.',
        am: 'ተሽከርካሪዎችንና ማሽኖችን መመርመርና መጠገን።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Civil Engineer', am: 'የሲቪል መሐንዲስ'),
      blurb: LocalizedText(
        en: 'Design roads, bridges and buildings.',
        am: 'መንገዶችን፣ ድልድዮችንና ሕንፃዎችን መንደፍ።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Farmer / Agronomist', am: 'አርሶ አደር / የግብርና ባለሙያ'),
      blurb: LocalizedText(
        en: 'Grow crops and manage land and animals.',
        am: 'ሰብል ማብቀልና መሬትና እንስሳትን ማስተዳደር።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Pilot', am: 'አብራሪ (ፓይለት)'),
      blurb: LocalizedText(
        en: 'Operate aircraft and manage flights.',
        am: 'አውሮፕላን ማብረርና በረራዎችን ማስተዳደር።',
      ),
    ),
  ],
  RiasecArea.investigative: <CareerMatch>[
    CareerMatch(
      name: LocalizedText(en: 'Doctor / Physician', am: 'ሐኪም'),
      blurb: LocalizedText(
        en: 'Diagnose and treat illness.',
        am: 'በሽታን መመርመርና ማከም።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Data Scientist', am: 'የዳታ ሳይንቲስት'),
      blurb: LocalizedText(
        en: 'Find patterns and insight in data.',
        am: 'ከመረጃ ውስጥ ስርዓቶችንና ግንዛቤዎችን ማግኘት።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Research Scientist', am: 'ተመራማሪ ሳይንቲስት'),
      blurb: LocalizedText(
        en: 'Run experiments to answer questions.',
        am: 'ጥያቄዎችን ለመመለስ ሙከራዎችን ማካሄድ።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Software Developer', am: 'ሶፍትዌር አበልጻጊ'),
      blurb: LocalizedText(
        en: 'Design and build software systems.',
        am: 'የሶፍትዌር ስርዓቶችን መንደፍና መገንባት።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Pharmacist', am: 'ፋርማሲስት'),
      blurb: LocalizedText(
        en: 'Prepare medicines and advise on their use.',
        am: 'መድኃኒት ማዘጋጀትና ስለ አጠቃቀሙ ማማከር።',
      ),
    ),
  ],
  RiasecArea.artistic: <CareerMatch>[
    CareerMatch(
      name: LocalizedText(en: 'Graphic Designer', am: 'ግራፊክ ዲዛይነር'),
      blurb: LocalizedText(
        en: 'Create visuals for brands and media.',
        am: 'ለብራንዶችና ለሚዲያ ምስሎችን መፍጠር።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Writer / Journalist', am: 'ጸሐፊ / ጋዜጠኛ'),
      blurb: LocalizedText(
        en: 'Tell stories through words.',
        am: 'በቃላት አማካኝነት ታሪኮችን ማቅረብ።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Musician', am: 'ሙዚቀኛ'),
      blurb: LocalizedText(
        en: 'Compose, perform or produce music.',
        am: 'ሙዚቃ መድረስ፣ መጫወት ወይም ማዘጋጀት።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Architect', am: 'አርክቴክት'),
      blurb: LocalizedText(
        en: 'Design creative, functional spaces.',
        am: 'ፈጠራዊና ተግባራዊ ቦታዎችን መንደፍ።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Photographer / Filmmaker', am: 'ፎቶግራፈር / ፊልም ሰሪ'),
      blurb: LocalizedText(
        en: 'Capture and craft visual stories.',
        am: 'ምስላዊ ታሪኮችን መቅረጽና መስራት።',
      ),
    ),
  ],
  RiasecArea.social: <CareerMatch>[
    CareerMatch(
      name: LocalizedText(en: 'Teacher', am: 'መምህር'),
      blurb: LocalizedText(
        en: 'Educate and guide students.',
        am: 'ተማሪዎችን ማስተማርና መምራት።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Nurse', am: 'ነርስ'),
      blurb: LocalizedText(
        en: 'Care for patients’ health and comfort.',
        am: 'የበሽተኞችን ጤናና ምቾት መንከባከብ።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Counselor', am: 'አማካሪ (ካውንስለር)'),
      blurb: LocalizedText(
        en: 'Support people through challenges.',
        am: 'ሰዎችን በችግር ጊዜ መደገፍ።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Social Worker', am: 'የማኅበራዊ ጉዳይ ባለሙያ'),
      blurb: LocalizedText(
        en: 'Help families and communities thrive.',
        am: 'ቤተሰቦችና ማኅበረሰቦች እንዲበለጽጉ መርዳት።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Human Resources Specialist', am: 'የሰው ኃይል ባለሙያ'),
      blurb: LocalizedText(
        en: 'Support and develop people at work.',
        am: 'በሥራ ቦታ ሰዎችን መደገፍና ማብቃት።',
      ),
    ),
  ],
  RiasecArea.enterprising: <CareerMatch>[
    CareerMatch(
      name: LocalizedText(en: 'Entrepreneur', am: 'ሥራ ፈጣሪ'),
      blurb: LocalizedText(
        en: 'Start and grow your own venture.',
        am: 'የራስን ንግድ መጀመርና ማሳደግ።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Sales Manager', am: 'የሽያጭ ሥራ አስኪያጅ'),
      blurb: LocalizedText(
        en: 'Lead teams to win customers.',
        am: 'ደንበኞችን ለማግኘት ቡድኖችን መምራት።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Lawyer', am: 'ጠበቃ'),
      blurb: LocalizedText(
        en: 'Advise and advocate for clients.',
        am: 'ደንበኞችን ማማከርና መወከል።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Marketing Manager', am: 'የግብይት ሥራ አስኪያጅ'),
      blurb: LocalizedText(
        en: 'Promote products and shape demand.',
        am: 'ምርቶችን ማስተዋወቅና ፍላጎትን መቅረጽ።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Project Manager', am: 'የፕሮጀክት ሥራ አስኪያጅ'),
      blurb: LocalizedText(
        en: 'Lead projects from idea to delivery.',
        am: 'ፕሮጀክቶችን ከሃሳብ እስከ ፍጻሜ መምራት።',
      ),
    ),
  ],
  RiasecArea.conventional: <CareerMatch>[
    CareerMatch(
      name: LocalizedText(en: 'Accountant', am: 'የሂሳብ ባለሙያ (አካውንታንት)'),
      blurb: LocalizedText(
        en: 'Track finances and prepare reports.',
        am: 'ገንዘብን መከታተልና ሪፖርቶችን ማዘጋጀት።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Auditor', am: 'ኦዲተር'),
      blurb: LocalizedText(
        en: 'Check records for accuracy.',
        am: 'መዝገቦችን ለትክክለኛነት መፈተሽ።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Bank Officer', am: 'የባንክ ሹም'),
      blurb: LocalizedText(
        en: 'Manage accounts and transactions.',
        am: 'ሂሳቦችንና ግብይቶችን ማስተዳደር።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Administrative Officer', am: 'የአስተዳደር ሹም'),
      blurb: LocalizedText(
        en: 'Keep an organization running smoothly.',
        am: 'አንድ ድርጅት በተስተካከለ ሁኔታ እንዲሠራ ማድረግ።',
      ),
    ),
    CareerMatch(
      name: LocalizedText(en: 'Data Analyst', am: 'የዳታ ተንታኝ'),
      blurb: LocalizedText(
        en: 'Organize and report on business data.',
        am: 'የንግድ መረጃን ማደራጀትና ሪፖርት ማድረግ።',
      ),
    ),
  ],
};
