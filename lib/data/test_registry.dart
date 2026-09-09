import 'career_items.dart';
import 'eq_items.dart';
import 'leadership_items.dart';
import 'learning_items.dart';
import 'love_items.dart';
import 'mini_ipip_items.dart';
import 'models/question.dart';

/// Resolves a catalog test id to the ordered item list the quiz flow presents.
///
/// Keeps [TestSession] and the test-detail screen test-agnostic: both ask the
/// registry for a test's items rather than hard-coding a single test's data.
/// Unknown ids fall back to the Big Five items.
List<TestItem> itemsForTest(String testId) {
  switch (testId) {
    case 'career':
      return kCareerItems;
    case 'eq':
      return kEqItems;
    case 'love':
      return kLoveItems;
    case 'leadership':
      return kLeadershipItems;
    case 'learning':
      return kLearningItems;
    case 'bigfive':
    default:
      return kMiniIpipItems;
  }
}
