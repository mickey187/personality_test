import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/test_catalog_item.dart';
import '../../data/test_catalog.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../widgets/organic_widgets.dart';

/// Home screen: brand header, a one-line prompt, and the grid of tests. Only
/// available tests open; the rest show a "coming soon" badge.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String lang = Localizations.localeOf(context).languageCode;

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
            // Greeting.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Text(
                l10n.homeGreeting,
                style: AppFonts.body(
                  size: 15,
                  color: AppColors.bodyMuted,
                  height: 1.5,
                ),
              ),
            ),
            // Test grid.
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.94,
                  children: <Widget>[
                    for (final TestCatalogItem test in kTestCatalog)
                      _TestCard(test: test, lang: lang, l10n: l10n),
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
      child: const Icon(Icons.person_rounded, size: 18, color: AppColors.bg),
    );
  }
}

/// One test tile in the home grid.
class _TestCard extends StatelessWidget {
  const _TestCard({
    required this.test,
    required this.lang,
    required this.l10n,
  });

  final TestCatalogItem test;
  final String lang;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('${Routes.test}/${test.id}'),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Opacity(
                    opacity: test.available ? 1 : 0.5,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: test.color,
                      ),
                      child: Icon(test.icon, size: 20, color: AppColors.bg),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    test.name.resolve(lang),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.body(
                      size: 13,
                      weight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    test.duration.resolve(lang),
                    style: AppFonts.body(size: 11, color: AppColors.muted),
                  ),
                ],
              ),
            ),
            if (!test.available)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.text.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                  ),
                  child: Text(
                    l10n.soonBadge,
                    style: AppFonts.body(
                      size: 9,
                      weight: FontWeight.w600,
                      color: AppColors.muted,
                      letterSpacing: 0.27,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
