import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_scope.dart';
import 'core/fallback_localizations.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'router/app_router.dart';
import 'state/app_settings.dart';
import 'state/result_store.dart';
import 'state/test_session.dart';

/// Root widget: scope, theme, localisation and routing.
class WhoAmIApp extends StatelessWidget {
  const WhoAmIApp({
    super.key,
    required this.settings,
    required this.session,
    required this.results,
  });

  final AppSettings settings;
  final TestSession session;
  final ResultStore results;

  static final GoRouter _router = createAppRouter();

  @override
  Widget build(BuildContext context) {
    return AppScope(
      settings: settings,
      session: session,
      results: results,
      child: ListenableBuilder(
        listenable: settings,
        builder: (BuildContext context, _) {
          return MaterialApp.router(
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context).appTitle,
            locale: settings.locale,
            supportedLocales: enabledLocales,
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              FallbackMaterialLocalizationsDelegate(),
              FallbackWidgetsLocalizationsDelegate(),
              FallbackCupertinoLocalizationsDelegate(),
            ],
            theme: buildOrganicTheme(),
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
