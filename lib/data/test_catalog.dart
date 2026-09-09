import 'package:flutter/material.dart';

import 'models/question.dart';
import 'models/test_catalog_item.dart';

/// Catalog of tests shown on the home grid, taken verbatim from the approved
/// "Personality Test" Claude Design source (`TESTS`).
///
/// Only the Big Five test is [available] in this release; the others are
/// placeholders for the planned expansion and render as "coming soon". Icons
/// map the design's Lucide glyphs onto their closest Material equivalents.
const List<TestCatalogItem> kTestCatalog = <TestCatalogItem>[
  TestCatalogItem(
    id: 'bigfive',
    icon: Icons.person_rounded,
    color: Color(0xFF3982C6),
    available: true,
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
  ),
  TestCatalogItem(
    id: 'career',
    icon: Icons.business_center_rounded,
    color: Color(0xFF7A8A5E),
    available: true,
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
  ),
  TestCatalogItem(
    id: 'eq',
    icon: Icons.favorite_rounded,
    color: Color(0xFFE8A44A),
    available: true,
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
  ),
  TestCatalogItem(
    id: 'love',
    icon: Icons.volunteer_activism_rounded,
    color: Color(0xFFC65B8A),
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
  ),
  TestCatalogItem(
    id: 'leadership',
    icon: Icons.workspace_premium_rounded,
    color: Color(0xFF1A548C),
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
  ),
  TestCatalogItem(
    id: 'learning',
    icon: Icons.menu_book_rounded,
    color: Color(0xFFAEBF92),
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
  ),
];

/// Looks up a catalog item by [id], or `null` when unknown.
TestCatalogItem? testById(String id) {
  for (final TestCatalogItem item in kTestCatalog) {
    if (item.id == id) return item;
  }
  return null;
}
