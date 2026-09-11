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
      headlineColor: AppColors.accent,
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
                fontSize: 16,
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
              Align(
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
                      const SizedBox(height: 4),
                      Text(
                        l10n.eqResultsSubtitle,
                        textAlign: TextAlign.center,
                        style: AppFonts.body(size: 14, color: AppColors.muted),
                      ),
                      const SizedBox(height: 20),
                      _OverallHero(
                        result: result,
                        bandLabel: _bandLabel(result.overallLevel, l10n),
                        lang: lang,
                        l10n: l10n,
                      ),
                      const SizedBox(height: 24),
                      for (int i = 0; i < ranked.length; i++) ...<Widget>[
                        _DimensionBar(
                          dimension: ranked[i],
                          percent: result.percentFor(ranked[i]),
                          fraction: result.fractionFor(ranked[i]),
                          l10n: l10n,
                          order: i,
                        ),
                        if (i < ranked.length - 1) const SizedBox(height: 14),
                      ],
                      const SizedBox(height: 28),
                      _SectionTitle(l10n.eqStrengthsTitle),
                      const SizedBox(height: 12),
                      for (final EqDimension dim in strengths) ...<Widget>[
                        _DimensionCard(
                          text: kEqContent[dim]!
                              .descriptionFor(result.levelFor(dim))
                              .resolve(lang),
                          dimension: dim,
                          l10n: l10n,
                        ),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 16),
                      _SectionTitle(l10n.eqGrowthTitle),
                      const SizedBox(height: 12),
                      for (final EqDimension dim in growth) ...<Widget>[
                        _DimensionCard(
                          text: kEqContent[dim]!.tip.resolve(lang),
                          dimension: dim,
                          l10n: l10n,
                          icon: Icons.tips_and_updates_outlined,
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
                fontSize: 16,
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

/// The overall EQ score headline: a big percentage, the band label and a
/// one-line summary of what that band means.
class _OverallHero extends StatelessWidget {
  const _OverallHero({
    required this.result,
    required this.bandLabel,
    required this.lang,
    required this.l10n,
  });

  final EqResult result;
  final String bandLabel;
  final String lang;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: <Widget>[
          Text(
            l10n.eqOverallLabel,
            style: AppFonts.body(size: 13, color: AppColors.muted),
          ),
          const SizedBox(height: 6),
          Text(
            '${result.overallPercent}%',
            style: AppFonts.display(size: 48, color: AppColors.accent),
          ),
          const SizedBox(height: 2),
          Text(
            bandLabel,
            style: AppFonts.body(
              size: 15,
              weight: FontWeight.w700,
              color: AppColors.accentActive,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            kEqOverallContent[result.overallLevel]!.resolve(lang),
            textAlign: TextAlign.center,
            style: AppFonts.body(
              size: 13,
              color: AppColors.bodyMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// One EQ dimension as a label + percentage + animated bar.
class _DimensionBar extends StatelessWidget {
  const _DimensionBar({
    required this.dimension,
    required this.percent,
    required this.fraction,
    required this.l10n,
    required this.order,
  });

  final EqDimension dimension;
  final int percent;
  final double fraction;
  final AppLocalizations l10n;
  final int order;

  @override
  Widget build(BuildContext context) {
    final Color color = kEqColors[dimension]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                dimension.label(l10n),
                style: AppFonts.body(size: 14, weight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$percent%',
              style: AppFonts.body(
                size: 14,
                weight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: Stack(
            children: <Widget>[
              Container(
                height: 8,
                color: AppColors.text.withValues(alpha: 0.08),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: fraction.clamp(0.0, 1.0)),
                duration: Duration(milliseconds: 800 + order * 100),
                curve: Curves.easeOutCubic,
                builder: (BuildContext context, double value, _) {
                  return FractionallySizedBox(
                    widthFactor: value,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(AppRadii.pill),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A card for a strength description or a growth tip, keyed by dimension colour.
class _DimensionCard extends StatelessWidget {
  const _DimensionCard({
    required this.text,
    required this.dimension,
    required this.l10n,
    this.icon,
  });

  final String text;
  final EqDimension dimension;
  final AppLocalizations l10n;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final Color color = kEqColors[dimension]!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 8),
              ] else ...<Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  dimension.label(l10n),
                  style: AppFonts.body(size: 14, weight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: AppFonts.body(
              size: 13,
              color: AppColors.bodyMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: AppFonts.body(size: 16, weight: FontWeight.w700),
      ),
    );
  }
}
