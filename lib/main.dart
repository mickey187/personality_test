import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/ads/ad_service.dart';
import 'data/result_repository.dart';
import 'state/app_settings.dart';
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

  // Kick off AdMob init in the background so it never blocks first paint.
  AdService.instance.init();

  runApp(
    WhoAmIApp(
      settings: settings,
      session: session,
      results: results,
    ),
  );
}
