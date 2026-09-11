import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/ads/ad_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/career_content.dart';
import '../../data/models/riasec.dart';
import '../../data/test_catalog.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../share/share_card_data.dart';
import '../widgets/organic_widgets.dart';

/// Shows the Career Aptitude (RIASEC) result: a Holland code, the six interest
/// bars, the strongest areas described, and careers that fit.
class CareerResultsScreen extends StatefulWidget {
  const CareerResultsScreen({super.key});

  @override
  State<CareerResultsScreen> createState() => _CareerResultsScreenState();
}

class _CareerResultsScreenState extends State<CareerResultsScreen> {
  bool _revealed = false;
  bool _revealing = false;

  void _retake(BuildContext context) {
    AppScope.sessionOf(context).reset();
    context.go(Routes.landing);
  }

  Future<void> _reveal() async {
    if (_revealing) return;
    setState(() => _revealing = true);
    // Interstitial gates the reveal — same placement as the Big Five results.
    await AdService.instance.showInterstitial();
    if (!mounted) return;
    setState(() {
      _revealed = true;
      _revealing = false;
    });
  }

  /// Holland code as the headline, the six interest areas as bars.
  ShareCardData _shareData(
    CareerResult result,
    String lang,
    AppLocalizations l10n,
  ) {
    final List<RiasecArea> ranked = result.ranked;
    return ShareCardData(
      profileLabel: testById('career')!.name.resolve(lang),
      headline: result.hollandCode,
      headlineColor: kRiasecColors[ranked.first]!,
      stats: <ShareStat>[
        for (final RiasecArea area in ranked)
          ShareStat(
            label: area.label(l10n),
            percent: result.percentFor(area),
            fraction: result.fractionFor(area),
            color: kRiasecColors[area]!,
          ),
      ],
      shareText: l10n.careerShareText(result.hollandCode, Brand.storeUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String lang = Localizations.localeOf(context).languageCode;
    final CareerResult? result = AppScope.careerResultsOf(context).current;
    final Color accent = testById('career')?.color ?? AppColors.accent;

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

    final List<RiasecArea> ranked = result.ranked;
    final List<RiasecArea> top3 = ranked.take(3).toList();

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
                        l10n.careerResultsTitle,
                        textAlign: TextAlign.center,
                        style: AppFonts.ethiopic(size: 24),
                      ),
                      const SizedBox(height: 20),
                      ResultHeroCard(
                        eyebrow: l10n.careerCodeLabel,
                        headline: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (final RiasecArea area in top3) ...<Widget>[
                              Text(
                                area.letter,
                                style: AppFonts.display(
                                  size: 42,
                                  color: kRiasecColors[area]!,
                                ),
                              ),
                              if (area != top3.last) const SizedBox(width: 6),
                            ],
                          ],
                        ),
                        description: top3.map((RiasecArea a) => a.label(l10n)).join(' · '),
                      ),
                      const SizedBox(height: 24),
                      // Full six-area interest profile, strongest first.
                      for (int i = 0; i < ranked.length; i++) ...<Widget>[
                        DimensionRow(
                          label: ranked[i].label(l10n),
                          percent: result.percentFor(ranked[i]),
                          fraction: result.fractionFor(ranked[i]),
                          color: kRiasecColors[ranked[i]]!,
                          order: i,
                        ),
                        if (i < ranked.length - 1) const SizedBox(height: 14),
                      ],
                      const SizedBox(height: 26),
                      SectionTitle(l10n.careerTopInterests),
                      const SizedBox(height: 12),
                      for (final RiasecArea area in top3) ...<Widget>[
                        InsightCard(
                          color: kRiasecColors[area]!,
                          icon: Icons.explore_rounded,
                          label: area.label(l10n),
                          children: <Widget>[
                            Text(
                              kCareerAreaContent[area]!.resolve(lang),
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
                      SectionTitle(l10n.careersThatFit),
                      const SizedBox(height: 12),
                      ..._buildCareerCards(top3, lang, accent),
                      const SizedBox(height: 20),
                      Text(
                        l10n.onetAttribution,
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

  /// Career suggestions drawn from the top-three areas — up to three per area,
  /// de-duplicated by English name so a career never appears twice.
  List<Widget> _buildCareerCards(List<RiasecArea> top3, String lang, Color accent) {
    final List<CareerMatch> picks = <CareerMatch>[];
    final Set<String> seen = <String>{};
    for (final RiasecArea area in top3) {
      for (final CareerMatch match in kCareerMatches[area]!.take(3)) {
        if (seen.add(match.name.en)) picks.add(match);
      }
    }
    return <Widget>[
      for (int i = 0; i < picks.length; i++) ...<Widget>[
        InsightCard(
          color: accent,
          icon: Icons.work_outline_rounded,
          label: picks[i].name.resolve(lang),
          children: <Widget>[
            Text(
              picks[i].blurb.resolve(lang),
              style: AppFonts.body(size: 12.5, color: AppColors.bodyMuted, height: 1.4),
            ),
          ],
        ),
        if (i < picks.length - 1) const SizedBox(height: 10),
      ],
    ];
  }
}
