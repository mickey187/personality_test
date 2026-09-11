import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/test_catalog_item.dart';
import '../../data/test_catalog.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../widgets/organic_widgets.dart';

/// Home screen: brand header, a "build your profile" headline, a completion
/// strip across the six assessments, and the assessment list. Every test is
/// available; each card states what it measures, why it matters, and its
/// time/question-count meta.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// How many of the six tests already have a saved result, read straight
  /// from the existing per-test stores (no new aggregation logic).
  int _completedCount(BuildContext context) {
    int done = 0;
    if (AppScope.resultsOf(context).current != null) done++;
    if (AppScope.careerResultsOf(context).current != null) done++;
    if (AppScope.eqResultsOf(context).current != null) done++;
    if (AppScope.loveResultsOf(context).current != null) done++;
    if (AppScope.leadershipResultsOf(context).current != null) done++;
    if (AppScope.learningResultsOf(context).current != null) done++;
    return done;
  }

  bool _isDone(BuildContext context, String testId) {
    switch (testId) {
      case 'bigfive':
        return AppScope.resultsOf(context).current != null;
      case 'career':
        return AppScope.careerResultsOf(context).current != null;
      case 'eq':
        return AppScope.eqResultsOf(context).current != null;
      case 'love':
        return AppScope.loveResultsOf(context).current != null;
      case 'leadership':
        return AppScope.leadershipResultsOf(context).current != null;
      case 'learning':
        return AppScope.learningResultsOf(context).current != null;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String lang = Localizations.localeOf(context).languageCode;
    final int done = _completedCount(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header: brand mark + language toggle.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const _BrandMark(),
                      const SizedBox(width: 10),
                      Text(
                        Brand.nameAm,
                        style: AppFonts.ethiopic(size: 18, height: 1.2),
                      ),
                    ],
                  ),
                  const LanguageToggle(),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      l10n.homeHeadline,
                      style: AppFonts.display(size: 28, height: 1.2),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.homeGreeting,
                      style: AppFonts.body(
                        size: 14.5,
                        color: AppColors.bodyMuted,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _ProfileStrip(done: done, total: kTestCatalog.length, l10n: l10n),
                    const SizedBox(height: 24),
                    for (final TestCatalogItem test in kTestCatalog) ...<Widget>[
                      _AssessmentCard(
                        test: test,
                        lang: lang,
                        l10n: l10n,
                        done: _isDone(context, test.id),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),
            ),
            // Footer link.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: TextButton(
                onPressed: () => context.push(Routes.about),
                style: TextButton.styleFrom(foregroundColor: AppColors.muted),
                child: Text(
                  l10n.aboutLink,
                  style: AppFonts.body(size: 13, color: AppColors.muted),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The 36px gradient brand circle with a person glyph, shown in the header.
class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[AppColors.accent, AppColors.accent2],
        ),
      ),
      child: const Icon(Icons.person_rounded, size: 18, color: AppColors.surface),
    );
  }
}

/// A slim "Your Profile" strip: a dot per test (filled once its result is
/// saved) and a short completion count — the light, non-invasive version of
/// the brief's "unified personal profile" concept.
class _ProfileStrip extends StatelessWidget {
  const _ProfileStrip({required this.done, required this.total, required this.l10n});

  final int done;
  final int total;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.profileStripTitle,
                  style: AppFonts.body(size: 13.5, weight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.profileStripProgress(done, total),
                  style: AppFonts.body(size: 12.5, color: AppColors.muted),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              for (int i = 0; i < kTestCatalog.length; i++) ...<Widget>[
                _ProfileDot(color: kTestCatalog[i].color, filled: i < done),
                if (i < kTestCatalog.length - 1) const SizedBox(width: 5),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileDot extends StatelessWidget {
  const _ProfileDot({required this.color, required this.filled});

  final Color color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9,
      height: 9,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? color : AppColors.border,
      ),
    );
  }
}

/// One assessment row: icon badge, title + why-it-matters line, meta row,
/// trailing chevron. All six share this template but are visually
/// distinguished by their own accent colour, icon and copy.
class _AssessmentCard extends StatelessWidget {
  const _AssessmentCard({
    required this.test,
    required this.lang,
    required this.l10n,
    required this.done,
  });

  final TestCatalogItem test;
  final String lang;
  final AppLocalizations l10n;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadii.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('${Routes.test}/${test.id}'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconBadge(icon: test.icon, color: test.color, size: 46),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            test.name.resolve(lang),
                            style: AppFonts.body(size: 16, weight: FontWeight.w600),
                          ),
                        ),
                        if (done)
                          const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: AppColors.accent,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      test.whyItMatters.resolve(lang),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.body(
                        size: 13,
                        color: AppColors.bodyMuted,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
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
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
