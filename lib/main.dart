import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/ads/ad_service.dart';
import 'data/career_result_repository.dart';
import 'data/eq_result_repository.dart';
import 'data/leadership_result_repository.dart';
import 'data/learning_result_repository.dart';
import 'data/love_result_repository.dart';
import 'data/result_repository.dart';
import 'state/app_settings.dart';
import 'state/career_result_store.dart';
import 'state/eq_result_store.dart';
import 'state/leadership_result_store.dart';
import 'state/learning_result_store.dart';
import 'state/love_result_store.dart';
import 'state/result_store.dart';
import 'state/test_session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final AppSettings settings = AppSettings(prefs);
  await settings.load();

  final TestSession session = TestSession(prefs);
  await session.restore();

  final ResultStore results = ResultStore(ResultRepository(prefs));

  final CareerResultStore careerResults =
      CareerResultStore(CareerResultRepository(prefs));

  final EqResultStore eqResults = EqResultStore(EqResultRepository(prefs));

  final LoveResultStore loveResults =
      LoveResultStore(LoveResultRepository(prefs));

  final LeadershipResultStore leadershipResults =
      LeadershipResultStore(LeadershipResultRepository(prefs));

  final LearningResultStore learningResults =
      LearningResultStore(LearningResultRepository(prefs));

  // Kick off AdMob init in the background so it never blocks first paint.
  AdService.instance.init();

  runApp(
    WhoAmIApp(
      settings: settings,
      session: session,
      results: results,
      careerResults: careerResults,
      eqResults: eqResults,
      loveResults: loveResults,
      leadershipResults: leadershipResults,
      learningResults: learningResults,
    ),
  );
}
