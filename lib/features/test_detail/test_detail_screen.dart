import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/test_catalog_item.dart';
import '../../data/test_catalog.dart';
import '../../data/test_registry.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../widgets/organic_widgets.dart';

/// Intro screen for a single test: hero icon, blurb, meta, and the start CTA
/// (or a locked "coming soon" state for tests that aren't available yet).
class TestDetailScreen extends StatelessWidget {
  const TestDetailScreen({super.key, required this.testId});

  final String testId;

  void _start(BuildContext context) {
    final session = AppScope.sessionOf(context);
    // Resume only a partially-answered session for THIS same test; otherwise
    // (re)load this test's items and start fresh.
    if (!(session.hasInProgress && session.testId == testId)) {
      session.configure(testId: testId, items: itemsForTest(testId));
    }
    context.push('${Routes.test}/$testId/questions');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String lang = Localizations.localeOf(context).languageCode;
    final TestCatalogItem? test = testById(testId);

    // Unknown id — bounce home.
    if (test == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(Routes.landing);
      });
      return const Scaffold();
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BackChevron(onTap: () => context.pop()),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                child: Column(
                  children: <Widget>[
                    _HeroIcon(icon: test.icon, color: test.color),
                    const SizedBox(height: 20),
                    Text(
                      test.name.resolve(lang),
                      textAlign: TextAlign.center,
                      style: AppFonts.body(size: 22, weight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      test.category.resolve(lang),
                      textAlign: TextAlign.center,
                      style: AppFonts.body(size: 13, color: AppColors.muted),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      test.description.resolve(lang),
                      textAlign: TextAlign.center,
                      style: AppFonts.body(
                        size: 15,
                        color: AppColors.bodyMuted,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _MetaChip(
                          icon: Icons.schedule_rounded,
                          label: test.duration.resolve(lang),
                        ),
                        const SizedBox(width: 16),
                        _MetaChip(
                          icon: Icons.help_outline_rounded,
                          label: test.questions.resolve(lang),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: test.available
                  ? PrimaryPillButton(
                      label: l10n.startButton,
                      onPressed: () => _start(context),
                    )
                  : _ComingSoonPlaceholder(label: l10n.comingSoon),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroIcon extends StatelessWidget {
  const _HeroIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(icon, size: 40, color: AppColors.bg),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 15, color: AppColors.muted),
        const SizedBox(width: 5),
        Text(label, style: AppFonts.body(size: 13, color: AppColors.muted)),
      ],
    );
  }
}

/// Locked state for tests that aren't available yet.
class _ComingSoonPlaceholder extends StatelessWidget {
  const _ComingSoonPlaceholder({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: AppFonts.display(size: 15, color: AppColors.muted),
      ),
    );
  }
}
