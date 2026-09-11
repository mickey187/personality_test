import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'models/question.dart';
import 'models/test_catalog_item.dart';

/// Catalog of tests shown on the home screen and their intro screens.
///
/// `scienceBased` mirrors the honesty distinction the original copy already
/// drew in its description text ("Science-based — …"): only Big Five,
/// Career and EQ are validated instruments; Love, Leadership and Learning
/// are popular, well-known frameworks rather than empirically validated
/// ones, so they don't carry the badge.
const List<TestCatalogItem> kTestCatalog = <TestCatalogItem>[
  TestCatalogItem(
    id: 'bigfive',
    icon: Icons.person_rounded,
    color: AppAccents.personality,
    available: true,
    scienceBased: true,
    name: LocalizedText(
      en: 'Personality (Big Five)',
      am: 'ስብዕና (Big Five)',
    ),
    category: LocalizedText(en: 'Personality Test', am: 'ስብዕና ምርመራ'),
    description: LocalizedText(
      en: 'Science-based — discover your 5 core personality traits using the '
          'Mini-IPIP (Big Five) model.',
      am: 'በሳይንስ ላይ የተመሠረተ — 5 ዋና ዋና ስብዕና ባህሪዎችዎን ይወቁ። Mini-IPIP (Big Five) ሞዴል።',
    ),
    duration: LocalizedText(en: '~2 min', am: '~2 ደቂቃ'),
    questions: LocalizedText(en: '20 questions', am: '20 ጥያቄዎች'),
    whyItMatters: LocalizedText(
      en: 'Understand how you naturally think, feel and connect with others.',
      am: 'በተፈጥሮዎ እንዴት እንደሚያስቡ፣ እንደሚሰማዎት እና ከሌሎች ጋር እንደሚገናኙ ይረዱ።',
    ),
    discoverBullets: <LocalizedText>[
      LocalizedText(
        en: 'How you naturally interact with others',
        am: 'ከሰዎች ጋር በተፈጥሮዎ እንዴት እንደሚገናኙ',
      ),
      LocalizedText(
        en: 'How you approach challenges and change',
        am: 'ተግዳሮቶችንና ለውጥን እንዴት እንደሚቋቋሙ',
      ),
      LocalizedText(en: 'What motivates and energizes you', am: 'የሚያነሳሳዎት ምንድን ነው'),
      LocalizedText(
        en: 'Your strongest personality traits',
        am: 'ጠንካራ የስብዕና ባህሪዎችዎ',
      ),
    ],
  ),
  TestCatalogItem(
    id: 'career',
    icon: Icons.business_center_rounded,
    color: AppAccents.career,
    available: true,
    scienceBased: true,
    name: LocalizedText(en: 'Career Aptitude', am: 'የሥራ ብቃት'),
    category: LocalizedText(en: 'Career Test', am: 'ሙያ ምርመራ'),
    description: LocalizedText(
      en: 'Science-based — discover the work you’re drawn to using the RIASEC '
          'model behind the U.S. Dept. of Labor’s O*NET Interest Profiler.',
      am: 'በሳይንስ ላይ የተመሠረተ — በ RIASEC ሞዴል (የአሜሪካ የሠራተኛ መሥሪያ ቤት O*NET Interest '
          'Profiler) አማካኝነት የሚስቡዎትን የሥራ ዘርፎች ይወቁ።',
    ),
    duration: LocalizedText(en: '~5 min', am: '~5 ደቂቃ'),
    questions: LocalizedText(en: '48 questions', am: '48 ጥያቄዎች'),
    whyItMatters: LocalizedText(
      en: 'See the kind of work that fits how you think and what energizes '
          'you.',
      am: 'ከአስተሳሰብዎና ጉልበት ከሚሰጥዎት ጋር የሚስማማውን የሥራ ዓይነት ይመልከቱ።',
    ),
    discoverBullets: <LocalizedText>[
      LocalizedText(
        en: "The work environments you're drawn to",
        am: 'የሚስቡዎት የሥራ ዓከባቢዎች',
      ),
      LocalizedText(en: 'Your strongest interest areas', am: 'ጠንካራ የፍላጎት ዘርፎችዎ'),
      LocalizedText(
        en: 'Careers that fit your profile',
        am: 'ከመገለጫዎ ጋር የሚስማሙ ሙያዎች',
      ),
      LocalizedText(
        en: 'Your three-letter Holland code',
        am: 'የእርስዎ የሶስት ፊደል Holland ኮድ',
      ),
    ],
  ),
  TestCatalogItem(
    id: 'eq',
    icon: Icons.favorite_rounded,
    color: AppAccents.eq,
    available: true,
    scienceBased: true,
    name: LocalizedText(en: 'Emotional Intelligence', am: 'ስሜታዊ ብልህነት'),
    category: LocalizedText(en: 'EQ Test', am: 'EQ ምርመራ'),
    description: LocalizedText(
      en: 'Science-based — measure your emotional intelligence across four '
          'skills using the Wong & Law (WLEIS) model.',
      am: 'በሳይንስ ላይ የተመሠረተ — በ Wong & Law (WLEIS) ሞዴል አማካኝነት ስሜታዊ ብልህነትዎን በአራት '
          'ክህሎቶች ይለኩ።',
    ),
    duration: LocalizedText(en: '~6 min', am: '~6 ደቂቃ'),
    questions: LocalizedText(en: '40 questions', am: '40 ጥያቄዎች'),
    whyItMatters: LocalizedText(
      en: 'Learn how you read, use and manage emotions — yours and others’.',
      am: 'ስሜቶችን (የራስዎንም የሌሎችንም) እንዴት እንደሚያነቡ፣ እንደሚጠቀሙና እንደሚቆጣጠሩ ይወቁ።',
    ),
    discoverBullets: <LocalizedText>[
      LocalizedText(
        en: 'How well you understand your own emotions',
        am: 'የራስዎን ስሜት ምን ያህል እንደሚረዱ',
      ),
      LocalizedText(
        en: 'How you read emotions in others',
        am: 'የሌሎችን ስሜት እንዴት እንደሚያነቡ',
      ),
      LocalizedText(
        en: 'How you use emotion to solve problems',
        am: 'ስሜትን ችግር ለመፍታት እንዴት እንደሚጠቀሙ',
      ),
      LocalizedText(
        en: 'How steady you stay under pressure',
        am: 'በጫና ውስጥ ምን ያህል የተረጋጉ እንደሆኑ',
      ),
    ],
  ),
  TestCatalogItem(
    id: 'love',
    icon: Icons.volunteer_activism_rounded,
    color: AppAccents.love,
    available: true,
    name: LocalizedText(en: 'Love Language', am: 'የፍቅር ቋንቋ'),
    category: LocalizedText(en: 'Relationship Test', am: 'ግንኙነት ምርመራ'),
    description: LocalizedText(
      en: "Discover how you most feel love — your primary love language, based "
          "on Gary Chapman's five love languages.",
      am: 'ፍቅርን በምን መንገድ በጣም እንደሚሰማዎት ይወቁ — በጋሪ ቻፕማን አምስት የፍቅር ቋንቋዎች ላይ '
          'የተመሠረተ የእርስዎ ዋና የፍቅር ቋንቋ።',
    ),
    duration: LocalizedText(en: '~4 min', am: '~4 ደቂቃ'),
    questions: LocalizedText(en: '25 questions', am: '25 ጥያቄዎች'),
    whyItMatters: LocalizedText(
      en: 'Discover how you most naturally feel — and show — love.',
      am: 'ፍቅርን በተፈጥሮዎ እንዴት እንደሚሰማዎትና እንደሚገልጹ ይወቁ።',
    ),
    discoverBullets: <LocalizedText>[
      LocalizedText(en: 'How you feel most loved', am: 'ፍቅር ሲሰማዎት ምን እንደሚመስል'),
      LocalizedText(
        en: 'How you naturally show affection',
        am: 'በተፈጥሮዎ ፍቅርን እንዴት እንደሚገልጹ',
      ),
      LocalizedText(
        en: 'What to share with people close to you',
        am: 'ለቅርብ ሰዎችዎ ምን ማካፈል እንዳለብዎት',
      ),
      LocalizedText(en: 'Your primary love language', am: 'ዋናው የፍቅር ቋንቋዎ'),
    ],
  ),
  TestCatalogItem(
    id: 'leadership',
    icon: Icons.workspace_premium_rounded,
    color: AppAccents.leadership,
    available: true,
    name: LocalizedText(en: 'Leadership Style', am: 'የአመራር ዘይቤ'),
    category: LocalizedText(en: 'Career Test', am: 'ሙያ ምርመራ'),
    description: LocalizedText(
      en: "Discover the leadership styles you lean on, based on Daniel "
          "Goleman's six leadership styles.",
      am: 'የሚጠቀሙባቸውን የአመራር ዘይቤዎች ይወቁ — በዳንኤል ጎልማን ስድስት የአመራር ዘይቤዎች ላይ የተመሠረተ።',
    ),
    duration: LocalizedText(en: '~6 min', am: '~6 ደቂቃ'),
    questions: LocalizedText(en: '36 questions', am: '36 ጥያቄዎች'),
    whyItMatters: LocalizedText(
      en: 'See the styles you lean on when guiding and motivating others.',
      am: 'ሌሎችን ሲመሩና ሲያነሳሱ የሚጠቀሙባቸውን ዘይቤዎች ይመልከቱ።',
    ),
    discoverBullets: <LocalizedText>[
      LocalizedText(
        en: 'The leadership styles you lean on most',
        am: 'በብዛት የሚጠቀሙባቸው የአመራር ዘይቤዎች',
      ),
      LocalizedText(
        en: 'How you motivate the people around you',
        am: 'በዙሪያዎ ያሉ ሰዎችን እንዴት እንደሚያነሳሱ',
      ),
      LocalizedText(
        en: 'Your style in high-pressure moments',
        am: 'በጫና ጊዜ ያለዎት ዘይቤ',
      ),
      LocalizedText(
        en: 'Where you can flex your approach',
        am: 'አካሄድዎን ሊያስተካክሉባቸው የሚችሉ ቦታዎች',
      ),
    ],
  ),
  TestCatalogItem(
    id: 'learning',
    icon: Icons.menu_book_rounded,
    color: AppAccents.learning,
    available: true,
    name: LocalizedText(en: 'Learning Style', am: 'የመማር ዘዴ'),
    category: LocalizedText(en: 'Self-Knowledge', am: 'ራስን ማወቅ'),
    description: LocalizedText(
      en: 'Discover how you prefer to learn with the VARK model — visual, '
          'auditory, reading/writing, or hands-on.',
      am: 'በ VARK ሞዴል መማርን በምን መንገድ እንደሚመርጡ ይወቁ — በማየት፣ በመስማት፣ በንባብና ጽሑፍ ወይም '
          'በተግባር።',
    ),
    duration: LocalizedText(en: '~3 min', am: '~3 ደቂቃ'),
    questions: LocalizedText(en: '20 questions', am: '20 ጥያቄዎች'),
    whyItMatters: LocalizedText(
      en: 'Find the way you absorb and retain new information best.',
      am: 'አዲስ መረጃን በተሻለ መንገድ የሚቀበሉበትንና የሚያስታውሱበትን መንገድ ያግኙ።',
    ),
    discoverBullets: <LocalizedText>[
      LocalizedText(
        en: 'How you prefer to take in new information',
        am: 'አዲስ መረጃን በምን መንገድ መቀበል እንደሚመርጡ',
      ),
      LocalizedText(
        en: 'Study habits that fit how you learn',
        am: 'ከመማሪያ ዘይቤዎ ጋር የሚስማሙ የጥናት ልማዶች',
      ),
      LocalizedText(en: 'Your dominant learning mode', am: 'ዋናው የመማሪያ ዘይቤዎ'),
      LocalizedText(
        en: 'Ways to mix modes for tougher material',
        am: 'ለከባድ ይዘት ዘይቤዎችን የመቀላቀል መንገዶች',
      ),
    ],
  ),
];

/// Looks up a catalog item by [id], or `null` when unknown.
TestCatalogItem? testById(String id) {
  for (final TestCatalogItem item in kTestCatalog) {
    if (item.id == id) return item;
  }
  return null;
}
