import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/ads/ad_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/test_result.dart';
import '../../data/models/trait.dart';
import '../../data/test_catalog.dart';
import '../../data/trait_content.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../share/share_card_data.dart';
import '../widgets/organic_widgets.dart';

/// Shows the five Big Five trait scores: a radar-chart snapshot up top, then
/// each trait as a card with a plain-language label, the clinical term as a
/// secondary caption, an animated bar, and a short description.
class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool _revealed = false;
  bool _revealing = false;

  void _retake(BuildContext context) {
    AppScope.sessionOf(context).reset();
    context.go(Routes.landing);
  }

  /// The five trait bars, in the fixed Big Five order — no single trait is
  /// "the" result, so the card has no headline.
  ShareCardData _shareData(TestResult result, AppLocalizations l10n) {
    return ShareCardData(
      profileLabel: l10n.shareCardProfileLabel,
      stats: <ShareStat>[
        for (final Trait trait in Trait.values)
          ShareStat(
            label: trait.label(l10n),
            percent: result[trait].percent,
            fraction: result[trait].fraction,
            color: kTraitColors[trait]!,
          ),
      ],
      shareText: l10n.shareSheetText(Brand.storeUrl),
    );
  }

  /// A one-line synthesis built from the two highest-scoring traits' own
  /// plain-language labels — no new taxonomy, just a headline drawn from
  /// content that already exists.
  String _snapshotLine(TestResult result, String lang) {
    final List<Trait> ranked = List<Trait>.of(Trait.values)
      ..sort((Trait a, Trait b) => result[b].percent.compareTo(result[a].percent));
    final String first = kTraitPlainLabel[ranked[0]]!.resolve(lang);
    final String second = kTraitPlainLabel[ranked[1]]!.resolve(lang);
    return '$first · $second';
  }

  Future<void> _reveal() async {
    if (_revealing) return;
    setState(() => _revealing = true);
    // Interstitial gates the reveal — the natural transition point right after
    // the quiz ends, before the payoff (PRD ad-placement decision).
    await AdService.instance.showInterstitial();
    if (!mounted) return;
    setState(() {
      _revealed = true;
      _revealing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String lang = Localizations.localeOf(context).languageCode;
    final TestResult? result = AppScope.resultsOf(context).current;
    final Color accent = testById('bigfive')?.color ?? AppColors.accent;

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
                        l10n.resultsTitle,
                        textAlign: TextAlign.center,
                        style: AppFonts.ethiopic(size: 24),
                      ),
                      const SizedBox(height: 20),
                      ResultHeroCard(
                        eyebrow: l10n.resultsSubtitle,
                        headline: TraitRadarChart(
                          fractions: <double>[
                            for (final Trait t in Trait.values) result[t].fraction,
                          ],
                          colors: <Color>[
                            for (final Trait t in Trait.values) kTraitColors[t]!,
                          ],
                        ),
                        description: _snapshotLine(result, lang),
                      ),
                      const SizedBox(height: 24),
                      for (int i = 0; i < Trait.values.length; i++) ...<Widget>[
                        _TraitCard(
                          trait: Trait.values[i],
                          score: result[Trait.values[i]],
                          lang: lang,
                          l10n: l10n,
                          order: i,
                        ),
                        if (i < Trait.values.length - 1)
                          const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 24),
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
                  extra: _shareData(result, l10n),
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

class _TraitCard extends StatelessWidget {
  const _TraitCard({
    required this.trait,
    required this.score,
    required this.lang,
    required this.l10n,
    required this.order,
  });

  final Trait trait;
  final TraitScore score;
  final String lang;
  final AppLocalizations l10n;
  final int order;

  @override
  Widget build(BuildContext context) {
    final Color color = kTraitColors[trait]!;
    final String description =
        kTraitContent[trait]!.descriptionFor(score.level).resolve(lang);

    return InsightCard(
      color: color,
      icon: _traitIcon(trait),
      label: kTraitPlainLabel[trait]!.resolve(lang),
      subLabel: '${l10n.bigFiveTraitLabel}: ${trait.label(l10n)}',
      trailing: Text(
        '${score.percent}%',
        style: AppFonts.body(size: 15, weight: FontWeight.w700, color: color),
      ),
      children: <Widget>[
        AnimatedBar(fraction: score.fraction, color: color, order: order),
        const SizedBox(height: 10),
        Text(
          description,
          style: AppFonts.body(size: 13, color: AppColors.bodyMuted, height: 1.5),
        ),
      ],
    );
  }

  IconData _traitIcon(Trait trait) {
    switch (trait) {
      case Trait.extraversion:
        return Icons.groups_rounded;
      case Trait.agreeableness:
        return Icons.favorite_rounded;
      case Trait.conscientiousness:
        return Icons.task_alt_rounded;
      case Trait.neuroticism:
        return Icons.waves_rounded;
      case Trait.openness:
        return Icons.auto_awesome_rounded;
    }
  }
}
