import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/ads/ad_service.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
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
    required this.onShare,
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
  final Future<void> Function() onShare;

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
              Align(alignment: Alignment.centerRight, child: LanguageToggle()),
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
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle,
                        textAlign: TextAlign.center,
                        style: AppFonts.body(size: 14, color: AppColors.muted),
                      ),
                      const SizedBox(height: 20),
                      _Hero(
                        label: widget.heroLabel,
                        value: widget.heroValue,
                        color: widget.heroColor,
                        description: widget.heroDescription,
                      ),
                      const SizedBox(height: 24),
                      for (int i = 0; i < widget.bars.length; i++) ...<Widget>[
                        _Bar(bar: widget.bars[i], order: i),
                        if (i < widget.bars.length - 1)
                          const SizedBox(height: 14),
                      ],
                      const SizedBox(height: 28),
                      _SectionTitle(widget.section1Title),
                      const SizedBox(height: 12),
                      for (final RankedCard c in widget.section1) ...<Widget>[
                        _Card(card: c),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 16),
                      _SectionTitle(widget.section2Title),
                      const SizedBox(height: 12),
                      for (final RankedCard c in widget.section2) ...<Widget>[
                        _Card(card: c),
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
                fontSize: 16,
                onPressed: widget.onShare,
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

class _Hero extends StatelessWidget {
  const _Hero({
    required this.label,
    required this.value,
    required this.color,
    required this.description,
  });

  final String label;
  final String value;
  final Color color;
  final String description;

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
            label,
            style: AppFonts.body(size: 13, color: AppColors.muted),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: AppFonts.display(size: 30, color: color, height: 1.15),
          ),
          const SizedBox(height: 10),
          Text(
            description,
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

class _Bar extends StatelessWidget {
  const _Bar({required this.bar, required this.order});

  final RankedBar bar;
  final int order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                bar.label,
                style: AppFonts.body(size: 14, weight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${bar.percent}%',
              style: AppFonts.body(
                size: 14,
                weight: FontWeight.w700,
                color: bar.color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: Stack(
            children: <Widget>[
              Container(height: 8, color: AppColors.text.withValues(alpha: 0.08)),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: bar.fraction.clamp(0.0, 1.0)),
                duration: Duration(milliseconds: 800 + order * 100),
                curve: Curves.easeOutCubic,
                builder: (BuildContext context, double value, _) {
                  return FractionallySizedBox(
                    widthFactor: value,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: bar.color,
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

class _Card extends StatelessWidget {
  const _Card({required this.card});

  final RankedCard card;

  @override
  Widget build(BuildContext context) {
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
              if (card.icon != null) ...<Widget>[
                Icon(card.icon, size: 16, color: card.color),
                const SizedBox(width: 8),
              ] else ...<Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration:
                      BoxDecoration(color: card.color, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  card.label,
                  style: AppFonts.body(size: 14, weight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            card.text,
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
