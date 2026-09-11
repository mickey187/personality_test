import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/ads/ad_service.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../share/share_card_data.dart';
import 'organic_widgets.dart';

/// One interest/style bar on a ranked-profile results screen.
class RankedBar {
  const RankedBar({
    required this.label,
    required this.percent,
    required this.fraction,
    required this.color,
  });

  final String label;
  final int percent;
  final double fraction;
  final Color color;
}

/// A titled card (a description or a tip) on a ranked-profile results screen.
class RankedCard {
  const RankedCard({
    required this.label,
    required this.color,
    required this.text,
    this.icon,
  });

  final String label;
  final Color color;
  final String text;
  final IconData? icon;
}

/// Shared results layout for tests that produce a ranked profile with a single
/// top ("primary"/"dominant") dimension — Love Language, Leadership, Learning.
///
/// Handles the interstitial-gated reveal, the hero, the sorted bars, two titled
/// card sections, the attribution footer, and the share/retake buttons. Each
/// test supplies a thin wrapper that maps its result into this view.
class RankedResultsView extends StatefulWidget {
  const RankedResultsView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.heroLabel,
    required this.heroValue,
    required this.heroColor,
    required this.heroDescription,
    required this.bars,
    required this.section1Title,
    required this.section1,
    required this.section2Title,
    required this.section2,
    required this.attribution,
    required this.shareData,
  });

  final String title;
  final String subtitle;
  final String heroLabel;
  final String heroValue;
  final Color heroColor;
  final String heroDescription;
  final List<RankedBar> bars;
  final String section1Title;
  final List<RankedCard> section1;
  final String section2Title;
  final List<RankedCard> section2;
  final String attribution;

  /// Result rendered as the shareable image on the share-preview screen.
  final ShareCardData shareData;

  @override
  State<RankedResultsView> createState() => _RankedResultsViewState();
}

class _RankedResultsViewState extends State<RankedResultsView> {
  bool _revealed = false;
  bool _revealing = false;

  void _retake(BuildContext context) {
    AppScope.sessionOf(context).reset();
    context.go(Routes.landing);
  }

  Future<void> _reveal() async {
    if (_revealing) return;
    setState(() => _revealing = true);
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

    if (!_revealed) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: PrimaryPillButton(
                label: _revealing ? '…' : l10n.seeResultButton,
                icon: Icons.visibility_rounded,
                color: widget.heroColor,
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
              const Align(alignment: Alignment.centerRight, child: LanguageToggle()),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: AppFonts.ethiopic(size: 24),
                      ),
                      const SizedBox(height: 20),
                      ResultHeroCard(
                        eyebrow: widget.heroLabel,
                        headline: Text(
                          widget.heroValue,
                          textAlign: TextAlign.center,
                          style: AppFonts.display(
                            size: 28,
                            color: widget.heroColor,
                            height: 1.15,
                          ),
                        ),
                        description: widget.heroDescription,
                      ),
                      const SizedBox(height: 24),
                      for (int i = 0; i < widget.bars.length; i++) ...<Widget>[
                        DimensionRow(
                          label: widget.bars[i].label,
                          percent: widget.bars[i].percent,
                          fraction: widget.bars[i].fraction,
                          color: widget.bars[i].color,
                          order: i,
                        ),
                        if (i < widget.bars.length - 1) const SizedBox(height: 14),
                      ],
                      const SizedBox(height: 26),
                      SectionTitle(widget.section1Title),
                      const SizedBox(height: 12),
                      for (final RankedCard c in widget.section1) ...<Widget>[
                        _card(c),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 12),
                      SectionTitle(widget.section2Title),
                      const SizedBox(height: 12),
                      for (final RankedCard c in widget.section2) ...<Widget>[
                        _card(c),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        widget.attribution,
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
                color: widget.heroColor,
                onPressed: () =>
                    context.push(Routes.share, extra: widget.shareData),
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

  Widget _card(RankedCard c) {
    return InsightCard(
      color: c.color,
      icon: c.icon ?? Icons.circle,
      label: c.label,
      children: <Widget>[
        Text(
          c.text,
          style: AppFonts.body(size: 13, color: AppColors.bodyMuted, height: 1.5),
        ),
      ],
    );
  }
}
