import 'package:go_router/go_router.dart';

import '../features/about/about_screen.dart';
import '../features/landing/landing_screen.dart';
import '../features/question/question_screen.dart';
import '../features/results/results_screen.dart';
import '../features/share/share_card_screen.dart';

/// Route path constants.
abstract final class Routes {
  static const String landing = '/';
  static const String test = '/test';
  static const String results = '/results';
  static const String share = '/results/share';
  static const String about = '/about';
}

/// Builds the app router. Flat routes matching the design's screen flow:
/// landing → test → results → (share), plus about.
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: Routes.landing,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.landing,
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        path: Routes.test,
        builder: (context, state) => const QuestionScreen(),
      ),
      GoRoute(
        path: Routes.results,
        builder: (context, state) => const ResultsScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'share',
            builder: (context, state) => const ShareCardScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.about,
        builder: (context, state) => const AboutScreen(),
      ),
    ],
  );
}
