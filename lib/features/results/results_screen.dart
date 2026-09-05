import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/ads/ad_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/test_result.dart';
import '../../data/models/trait.dart';
import '../../data/trait_content.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../widgets/organic_widgets.dart';

/// Shows the five Big Five trait scores as bars with a short description each.
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
                        l10n.resultsTitle,
                        textAlign: TextAlign.center,
                        style: AppFonts.ethiopic(size: 24),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.resultsSubtitle,
                        textAlign: TextAlign.center,
                        style: AppFonts.body(size: 14, color: AppColors.muted),
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
                          const SizedBox(height: 16),
                      ],
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              PrimaryPillButton(
                label: l10n.shareButton,
                icon: Icons.ios_share_rounded,
                fontSize: 16,
                onPressed: () => context.push(Routes.share),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  trait.label(l10n),
                  style: AppFonts.body(size: 14, weight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${score.percent}%',
                style: AppFonts.body(
                  size: 14,
                  weight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _TraitBar(fraction: score.fraction, color: color, order: order),
          const SizedBox(height: 10),
          Text(
            description,
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

class _TraitBar extends StatelessWidget {
  const _TraitBar({
    required this.fraction,
    required this.color,
    required this.order,
  });

  final double fraction;
  final Color color;
  final int order;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
    );
  }
}
