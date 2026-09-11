import 'package:go_router/go_router.dart';

import '../features/about/about_screen.dart';
import '../features/career_results/career_results_screen.dart';
import '../features/eq_results/eq_results_screen.dart';
import '../features/home/home_screen.dart';
import '../features/leadership_results/leadership_results_screen.dart';
import '../features/learning_results/learning_results_screen.dart';
import '../features/love_results/love_results_screen.dart';
import '../features/question/question_screen.dart';
import '../features/results/results_screen.dart';
import '../features/share/share_card_data.dart';
import '../features/share/share_card_screen.dart';
import '../features/test_detail/test_detail_screen.dart';

/// Route path constants.
abstract final class Routes {
  static const String landing = '/';
  static const String test = '/test';
  static const String results = '/results';

  /// Share preview for any test — push it with a [ShareCardData] as `extra`.
  static const String share = '/share';
  static const String careerResults = '/career/results';
  static const String eqResults = '/eq/results';
  static const String loveResults = '/love/results';
  static const String leadershipResults = '/leadership/results';
  static const String learningResults = '/learning/results';
  static const String about = '/about';
}

/// Builds the app router. Screen flow: home → test detail → questions →
/// results → (share), plus about.
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: Routes.landing,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.landing,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '${Routes.test}/:id',
        builder: (context, state) =>
            TestDetailScreen(testId: state.pathParameters['id']!),
        routes: <RouteBase>[
          GoRoute(
            path: 'questions',
            builder: (context, state) => const QuestionScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.results,
        builder: (context, state) => const ResultsScreen(),
      ),
      GoRoute(
        path: Routes.share,
        builder: (context, state) =>
            ShareCardScreen(data: state.extra as ShareCardData?),
      ),
      GoRoute(
        path: Routes.careerResults,
        builder: (context, state) => const CareerResultsScreen(),
      ),
      GoRoute(
        path: Routes.eqResults,
        builder: (context, state) => const EqResultsScreen(),
      ),
      GoRoute(
        path: Routes.loveResults,
        builder: (context, state) => const LoveResultsScreen(),
      ),
      GoRoute(
        path: Routes.leadershipResults,
        builder: (context, state) => const LeadershipResultsScreen(),
      ),
      GoRoute(
        path: Routes.learningResults,
        builder: (context, state) => const LearningResultsScreen(),
      ),
      GoRoute(
        path: Routes.about,
        builder: (context, state) => const AboutScreen(),
      ),
    ],
  );
}
