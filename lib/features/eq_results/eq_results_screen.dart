import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/ads/ad_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/eq_content.dart';
import '../../data/models/eq.dart';
import '../../data/test_catalog.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../share/share_card_data.dart';
import '../widgets/organic_widgets.dart';

/// Shows the EQ result: an overall score, the four skill bars, the user's
/// strongest skills described, and growth tips for the weakest.
class EqResultsScreen extends StatefulWidget {
  const EqResultsScreen({super.key});

  @override
  State<EqResultsScreen> createState() => _EqResultsScreenState();
}

class _EqResultsScreenState extends State<EqResultsScreen> {
  bool _revealed = false;
  bool _revealing = false;

  void _retake(BuildContext context) {
    AppScope.sessionOf(context).reset();
    context.go(Routes.landing);
  }

  Future<void> _reveal() async {
    if (_revealing) return;
    setState(() => _revealing = true);
    // Interstitial gates the reveal — same placement as the other tests.
    await AdService.instance.showInterstitial();
    if (!mounted) return;
    setState(() {
      _revealed = true;
      _revealing = false;
    });
  }

  /// Overall score as the headline, the four skills as bars.
  ShareCardData _shareData(
    EqResult result,
    String lang,
    AppLocalizations l10n,
  ) {
    final String band = _bandLabel(result.overallLevel, l10n);
    return ShareCardData(
      profileLabel: testById('eq')!.name.resolve(lang),
      headline: '${result.overallPercent}% · $band',
      headlineColor: AppAccents.eq,
      stats: <ShareStat>[
        for (final EqDimension dim in result.ranked)
          ShareStat(
            label: dim.label(l10n),
            percent: result.percentFor(dim),
            fraction: result.fractionFor(dim),
            color: kEqColors[dim]!,
          ),
      ],
      shareText: l10n.eqShareText(
        result.overallPercent,
        band,
        Brand.storeUrl,
      ),
    );
  }

  String _bandLabel(EqLevel level, AppLocalizations l10n) {
    switch (level) {
      case EqLevel.low:
        return l10n.eqLevelDeveloping;
      case EqLevel.mid:
        return l10n.eqLevelBalanced;
      case EqLevel.high:
        return l10n.eqLevelStrong;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String lang = Localizations.localeOf(context).languageCode;
    final EqResult? result = AppScope.eqResultsOf(context).current;
    final Color accent = testById('eq')?.color ?? AppColors.accent;

    // Deep-linked here without a result — bounce back to the landing screen.
    if (result == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(Routes.landing);
      });
      return const Scaffold();
    }

    if (!_revealed) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: PrimaryPillButton(
                label: _revealing ? '…' : l10n.seeResultButton,
                icon: Icons.visibility_rounded,
                color: accent,
                onPressed: _reveal,
              ),
            ),
          ),
        ),
      );
    }

    final List<EqDimension> ranked = result.ranked;
    final List<EqDimension> strengths = ranked.take(2).toList();
    final List<EqDimension> growth = ranked.reversed.take(2).toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.centerRight,
                child: LanguageToggle(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      Text(
                        l10n.eqResultsTitle,
                        textAlign: TextAlign.center,
                        style: AppFonts.ethiopic(size: 24),
                      ),
                      const SizedBox(height: 20),
                      ResultHeroCard(
                        eyebrow: l10n.eqOverallLabel,
                        headline: Column(
                          children: <Widget>[
                            Text(
                              '${result.overallPercent}%',
                              style: AppFonts.display(size: 46, color: accent),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _bandLabel(result.overallLevel, l10n),
                              style: AppFonts.body(
                                size: 15,
                                weight: FontWeight.w700,
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                        description: kEqOverallContent[result.overallLevel]!.resolve(lang),
                      ),
                      const SizedBox(height: 24),
                      for (int i = 0; i < ranked.length; i++) ...<Widget>[
                        DimensionRow(
                          label: ranked[i].label(l10n),
                          percent: result.percentFor(ranked[i]),
                          fraction: result.fractionFor(ranked[i]),
                          color: kEqColors[ranked[i]]!,
                          order: i,
                        ),
                        if (i < ranked.length - 1) const SizedBox(height: 14),
                      ],
                      const SizedBox(height: 26),
                      SectionTitle(l10n.eqStrengthsTitle),
                      const SizedBox(height: 12),
                      for (final EqDimension dim in strengths) ...<Widget>[
                        InsightCard(
                          color: kEqColors[dim]!,
                          icon: Icons.star_rounded,
                          label: dim.label(l10n),
                          children: <Widget>[
                            Text(
                              kEqContent[dim]!.descriptionFor(result.levelFor(dim)).resolve(lang),
                              style: AppFonts.body(
                                size: 13,
                                color: AppColors.bodyMuted,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 12),
                      SectionTitle(l10n.eqGrowthTitle),
                      const SizedBox(height: 12),
                      for (final EqDimension dim in growth) ...<Widget>[
                        InsightCard(
                          color: kEqColors[dim]!,
                          icon: Icons.tips_and_updates_outlined,
                          label: dim.label(l10n),
                          children: <Widget>[
                            Text(
                              kEqContent[dim]!.tip.resolve(lang),
                              style: AppFonts.body(
                                size: 13,
                                color: AppColors.bodyMuted,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        l10n.eqAttribution,
                        textAlign: TextAlign.center,
                        style: AppFonts.body(
                          size: 11,
                          color: AppColors.muted,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              PrimaryPillButton(
                label: l10n.shareButton,
                icon: Icons.ios_share_rounded,
                color: accent,
                onPressed: () => context.push(
                  Routes.share,
                  extra: _shareData(result, lang, l10n),
                ),
              ),
              const SizedBox(height: 10),
              SecondaryPillButton(
                label: l10n.retakeButton,
                onPressed: () => _retake(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
