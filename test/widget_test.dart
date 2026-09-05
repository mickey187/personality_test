import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personality_test/app.dart';
import 'package:personality_test/core/theme/app_theme.dart';
import 'package:personality_test/data/result_repository.dart';
import 'package:personality_test/state/app_settings.dart';
import 'package:personality_test/state/result_store.dart';
import 'package:personality_test/state/test_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> _buildApp() async {
  final prefs = await SharedPreferences.getInstance();
  final settings = AppSettings(prefs);
  await settings.load();
  final session = TestSession(prefs);
  await session.restore();
  final results = ResultStore(ResultRepository(prefs));
  return WhoAmIApp(settings: settings, session: session, results: results);
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    // Avoid network font fetches during tests.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('landing screen shows the brand and start button', (tester) async {
    await tester.pumpWidget(await _buildApp());
    await tester.pumpAndSettle();

    // Brand mark (always Amharic) is present.
    expect(find.text(Brand.nameAm), findsOneWidget);
    expect(find.text(Brand.tagline), findsOneWidget);
    // Amharic start button (default locale is am).
    expect(find.text('ጀምር'), findsOneWidget);
  });

  testWidgets('tapping start opens the first question', (tester) async {
    await tester.pumpWidget(await _buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('ጀምር'));
    await tester.pumpAndSettle();

    // Progress indicator for the first of twenty questions.
    expect(find.text('1 / 20'), findsOneWidget);
    // The five Likert options are shown.
    expect(find.text('በጣም ትክክል'), findsOneWidget);
  });
}
