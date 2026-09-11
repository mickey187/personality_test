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

    final List<RiasecArea> ranked = result.ranked;
    final List<RiasecArea> top3 = ranked.take(3).toList();

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
                        l10n.careerResultsTitle,
                        textAlign: TextAlign.center,
                        style: AppFonts.ethiopic(size: 24),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.careerResultsSubtitle,
                        textAlign: TextAlign.center,
                        style: AppFonts.body(size: 14, color: AppColors.muted),
                      ),
                      const SizedBox(height: 20),
                      _CodeHero(result: result, top3: top3, l10n: l10n),
                      const SizedBox(height: 24),
                      // Full six-area interest profile, strongest first.
                      for (int i = 0; i < ranked.length; i++) ...<Widget>[
                        _AreaBar(
                          area: ranked[i],
                          percent: result.percentFor(ranked[i]),
                          fraction: result.fractionFor(ranked[i]),
                          l10n: l10n,
                          order: i,
                        ),
                        if (i < ranked.length - 1) const SizedBox(height: 14),
                      ],
                      const SizedBox(height: 28),
                      _SectionTitle(l10n.careerTopInterests),
                      const SizedBox(height: 12),
                      for (final RiasecArea area in top3) ...<Widget>[
                        _InterestCard(area: area, lang: lang, l10n: l10n),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 16),
                      _SectionTitle(l10n.careersThatFit),
                      const SizedBox(height: 12),
                      ..._buildCareerCards(top3, lang),
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

  /// Career suggestions drawn from the top-three areas — up to three per area,
  /// de-duplicated by English name so a career never appears twice.
  List<Widget> _buildCareerCards(List<RiasecArea> top3, String lang) {
    final List<CareerMatch> picks = <CareerMatch>[];
    final Set<String> seen = <String>{};
    for (final RiasecArea area in top3) {
      for (final CareerMatch match in kCareerMatches[area]!.take(3)) {
        if (seen.add(match.name.en)) picks.add(match);
      }
    }
    return <Widget>[
      for (int i = 0; i < picks.length; i++) ...<Widget>[
        _CareerCard(match: picks[i], lang: lang),
        if (i < picks.length - 1) const SizedBox(height: 10),
      ],
    ];
  }
}

/// The Holland-code headline: the three letters and the areas they stand for.
class _CodeHero extends StatelessWidget {
  const _CodeHero({
    required this.result,
    required this.top3,
    required this.l10n,
  });

  final CareerResult result;
  final List<RiasecArea> top3;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: <Widget>[
          Text(
            l10n.careerCodeLabel,
            style: AppFonts.body(size: 13, color: AppColors.muted),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (final RiasecArea area in top3) ...<Widget>[
                Text(
                  area.letter,
                  style: AppFonts.display(
                    size: 44,
                    color: kRiasecColors[area]!,
                  ),
                ),
                if (area != top3.last) const SizedBox(width: 6),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Text(
            top3.map((RiasecArea a) => a.label(l10n)).join(' · '),
            textAlign: TextAlign.center,
            style: AppFonts.body(
              size: 13,
              weight: FontWeight.w600,
              color: AppColors.bodyMuted,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// One interest area as a label + percentage + animated bar.
class _AreaBar extends StatelessWidget {
  const _AreaBar({
    required this.area,
    required this.percent,
    required this.fraction,
    required this.l10n,
    required this.order,
  });

  final RiasecArea area;
  final int percent;
  final double fraction;
  final AppLocalizations l10n;
  final int order;

  @override
  Widget build(BuildContext context) {
    final Color color = kRiasecColors[area]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                area.label(l10n),
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

/// A strongest-area card: coloured accent, area label and its description.
class _InterestCard extends StatelessWidget {
  const _InterestCard({
    required this.area,
    required this.lang,
    required this.l10n,
  });

  final RiasecArea area;
  final String lang;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final Color color = kRiasecColors[area]!;
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
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  area.label(l10n),
                  style: AppFonts.body(size: 14, weight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
    );
  }
}

/// A single suggested occupation: name + one-line description.
class _CareerCard extends StatelessWidget {
  const _CareerCard({required this.match, required this.lang});

  final CareerMatch match;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.work_outline_rounded,
            size: 18,
            color: AppColors.accent,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  match.name.resolve(lang),
                  style: AppFonts.body(size: 14, weight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  match.blurb.resolve(lang),
                  style: AppFonts.body(
                    size: 12,
                    color: AppColors.bodyMuted,
                    height: 1.4,
                  ),
                ),
              ],
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
