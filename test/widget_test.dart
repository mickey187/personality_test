import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personality_test/app.dart';
import 'package:personality_test/core/theme/app_theme.dart';
import 'package:personality_test/data/career_result_repository.dart';
import 'package:personality_test/data/eq_result_repository.dart';
import 'package:personality_test/data/leadership_result_repository.dart';
import 'package:personality_test/data/learning_result_repository.dart';
import 'package:personality_test/data/love_result_repository.dart';
import 'package:personality_test/data/result_repository.dart';
import 'package:personality_test/state/app_settings.dart';
import 'package:personality_test/state/career_result_store.dart';
import 'package:personality_test/state/eq_result_store.dart';
import 'package:personality_test/state/leadership_result_store.dart';
import 'package:personality_test/state/learning_result_store.dart';
import 'package:personality_test/state/love_result_store.dart';
import 'package:personality_test/state/result_store.dart';
import 'package:personality_test/state/test_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The app's [GoRouter] is a static singleton, so navigation state carries over
/// between tests. Reset it to the landing route after pumping a fresh app.
Future<void> _resetToHome(WidgetTester tester) async {
  final BuildContext ctx = tester.element(find.byType(Navigator).first);
  GoRouter.of(ctx).go('/');
  await tester.pumpAndSettle();
}

Future<Widget> _buildApp() async {
  final prefs = await SharedPreferences.getInstance();
  final settings = AppSettings(prefs);
  await settings.load();
  final session = TestSession(prefs);
  await session.restore();
  final results = ResultStore(ResultRepository(prefs));
  final careerResults = CareerResultStore(CareerResultRepository(prefs));
  final eqResults = EqResultStore(EqResultRepository(prefs));
  final loveResults = LoveResultStore(LoveResultRepository(prefs));
  final leadershipResults =
      LeadershipResultStore(LeadershipResultRepository(prefs));
  final learningResults = LearningResultStore(LearningResultRepository(prefs));
  return WhoAmIApp(
    settings: settings,
    session: session,
    results: results,
    careerResults: careerResults,
    eqResults: eqResults,
    loveResults: loveResults,
    leadershipResults: leadershipResults,
    learningResults: learningResults,
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    // Avoid network font fetches during tests.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('home screen shows the brand and test grid', (tester) async {
    await tester.pumpWidget(await _buildApp());
    await tester.pumpAndSettle();

    // Brand mark (always Amharic) is present.
    expect(find.text(Brand.nameAm), findsOneWidget);
    // The Big Five test card (default locale is am).
    expect(find.text('ስብዕና (Big Five)'), findsOneWidget);
  });

  testWidgets('opening the Big Five test and starting shows the first question',
      (tester) async {
    await tester.pumpWidget(await _buildApp());
    await tester.pumpAndSettle();
    await _resetToHome(tester);

    // Open the Big Five detail screen, then start the test.
    await tester.tap(find.text('ስብዕና (Big Five)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ጀምር'));
    await tester.pumpAndSettle();

    // Progress indicator for the first of twenty questions.
    expect(find.text('1 / 20'), findsOneWidget);
    // The five Likert options are shown.
    expect(find.text('በጣም ትክክል'), findsOneWidget);
  });

  testWidgets('opening the Career test starts a 48-item like/dislike quiz',
      (tester) async {
    await tester.pumpWidget(await _buildApp());
    await tester.pumpAndSettle();
    await _resetToHome(tester);

    // Open the Career Aptitude detail screen, then start the test.
    await tester.tap(find.text('የሥራ ብቃት'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ጀምር'));
    await tester.pumpAndSettle();

    // Progress indicator for the first of forty-eight questions.
    expect(find.text('1 / 48'), findsOneWidget);
    // The career test uses the like/dislike Likert scale, not accuracy.
    expect(find.text('በጣም እወዳለሁ'), findsOneWidget);
  });

  testWidgets('opening the EQ test starts a 40-item agree/disagree quiz',
      (tester) async {
    await tester.pumpWidget(await _buildApp());
    await tester.pumpAndSettle();
    await _resetToHome(tester);

    // The EQ card is in the second grid row — scroll it into view first.
    final Finder eqCard = find.text('ስሜታዊ ብልህነት');
    await tester.ensureVisible(eqCard);
    await tester.pumpAndSettle();
    await tester.tap(eqCard);
    await tester.pumpAndSettle();
    await tester.tap(find.text('ጀምር'));
    await tester.pumpAndSettle();

    // Progress indicator for the first of forty questions.
    expect(find.text('1 / 40'), findsOneWidget);
    // The EQ test uses the agree/disagree Likert scale.
    expect(find.text('በጣም እስማማለሁ'), findsOneWidget);
  });

  Future<void> startTest(WidgetTester tester, String cardText) async {
    await tester.pumpWidget(await _buildApp());
    await tester.pumpAndSettle();
    await _resetToHome(tester);
    final Finder card = find.text(cardText);
    await tester.ensureVisible(card);
    await tester.pumpAndSettle();
    await tester.tap(card);
    await tester.pumpAndSettle();
    await tester.tap(find.text('ጀምር'));
    await tester.pumpAndSettle();
  }

  testWidgets('Love Language test starts a 25-item agree quiz', (tester) async {
    await startTest(tester, 'የፍቅር ቋንቋ');
    expect(find.text('1 / 25'), findsOneWidget);
    expect(find.text('በጣም እስማማለሁ'), findsOneWidget);
  });

  testWidgets('Leadership test starts a 36-item agree quiz', (tester) async {
    await startTest(tester, 'የአመራር ዘይቤ');
    expect(find.text('1 / 36'), findsOneWidget);
    expect(find.text('በጣም እስማማለሁ'), findsOneWidget);
  });

  testWidgets('Learning Style test starts a 20-item agree quiz', (tester) async {
    await startTest(tester, 'የመማር ዘዴ');
    expect(find.text('1 / 20'), findsOneWidget);
    expect(find.text('በጣም እስማማለሁ'), findsOneWidget);
  });
}
