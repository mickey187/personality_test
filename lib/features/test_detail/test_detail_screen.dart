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

/// Intro screen for a single test: hero illustration, blurb, meta, a
/// "you'll discover" list, and the start CTA (or a locked "coming soon"
/// state for tests that aren't available yet).
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
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BackChevron(onTap: () => context.pop()),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: _HeroBlob(icon: test.icon, color: test.color)),
                    const SizedBox(height: 22),
                    Text(
                      test.name.resolve(lang),
                      textAlign: TextAlign.center,
                      style: AppFonts.display(size: 24, height: 1.2),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        test.category.resolve(lang),
                        textAlign: TextAlign.center,
                        style: AppFonts.body(size: 13, color: AppColors.muted),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      test.description.resolve(lang),
                      textAlign: TextAlign.center,
                      style: AppFonts.body(
                        size: 15,
                        color: AppColors.bodyMuted,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 8,
                        children: <Widget>[
                          MetaChip(
                            icon: Icons.schedule_rounded,
                            label: test.duration.resolve(lang),
                          ),
                          MetaChip(
                            icon: Icons.help_outline_rounded,
                            label: test.questions.resolve(lang),
                          ),
                          if (test.scienceBased)
                            SoftBadge(
                              label: l10n.scienceBadge,
                              icon: Icons.verified_rounded,
                              color: test.color,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    if (test.discoverBullets.isNotEmpty) ...<Widget>[
                      Text(
                        l10n.discoverTitle,
                        style: AppFonts.body(size: 14, weight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadii.md),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (int i = 0; i < test.discoverBullets.length; i++) ...<Widget>[
                              _DiscoverBullet(
                                text: test.discoverBullets[i].resolve(lang),
                                color: test.color,
                              ),
                              if (i < test.discoverBullets.length - 1)
                                const SizedBox(height: 10),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: test.available
                  ? PrimaryPillButton(
                      label: l10n.startButton,
                      icon: Icons.arrow_forward_rounded,
                      color: test.color,
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

/// A soft colour-tinted blob behind the test's icon glyph — the app's
/// native stand-in for a per-assessment illustration.
class _HeroBlob extends StatelessWidget {
  const _HeroBlob({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 108,
      height: 108,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 108,
            height: 108,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.12),
            ),
          ),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[color, Color.lerp(color, Colors.black, 0.18)!],
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: color.withValues(alpha: 0.30),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(icon, size: 34, color: AppColors.surface),
          ),
        ],
      ),
    );
  }
}

class _DiscoverBullet extends StatelessWidget {
  const _DiscoverBullet({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Icon(Icons.check_rounded, size: 15, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: AppFonts.body(size: 14, color: AppColors.bodyMuted, height: 1.45),
          ),
        ),
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: AppFonts.display(size: 15, weight: FontWeight.w600, color: AppColors.muted),
      ),
    );
  }
}
