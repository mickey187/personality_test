import 'package:flutter/widgets.dart';

import 'state/app_settings.dart';
import 'state/result_store.dart';
import 'state/test_session.dart';

/// Exposes app-wide stores to the widget tree (mirrors the `FxAppScope`
/// convention: a plain [InheritedWidget] over [ChangeNotifier] stores).
class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.settings,
    required this.session,
    required this.results,
    required super.child,
  });

  final AppSettings settings;
  final TestSession session;
  final ResultStore results;

  static AppScope _of(BuildContext context) {
    final AppScope? scope = context.getInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope missing from the widget tree');
    return scope!;
  }

  static AppSettings settingsOf(BuildContext context) => _of(context).settings;
  static TestSession sessionOf(BuildContext context) => _of(context).session;
  static ResultStore resultsOf(BuildContext context) => _of(context).results;

  @override
  bool updateShouldNotify(AppScope oldWidget) =>
      settings != oldWidget.settings ||
      session != oldWidget.session ||
      results != oldWidget.results;
}
