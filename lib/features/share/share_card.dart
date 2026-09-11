import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import 'share_card_data.dart';

/// Aspect/size presets for the share card.
enum ShareFormat {
  /// 1:1 — good for Telegram / feed posts.
  square,

  /// 9:16 — Instagram / Telegram stories.
  story,
}

extension ShareFormatSize on ShareFormat {
  Size get previewSize => switch (this) {
        ShareFormat.square => const Size(280, 280),
        ShareFormat.story => const Size(240, 420),
      };

  /// How many bars fit without crowding the card. The square card gives part
  /// of its bar space to the headline when a test has one, so it shows only
  /// the strongest few; the tall story card fits every dimension.
  int maxStats({required bool hasHeadline}) => switch (this) {
        ShareFormat.square => hasHeadline ? 4 : 5,
        ShareFormat.story => 6,
      };
}

/// The branded, dark result card that gets rendered to an image and shared.
/// Deliberately self-contained (no inherited theme) so it renders identically
/// whether shown on screen or captured off-screen.
class ShareCard extends StatelessWidget {
  const ShareCard({
    super.key,
    required this.data,
    required this.format,
    required this.l10n,
  });

  final ShareCardData data;
  final ShareFormat format;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final Size size = format.previewSize;
    final bool isSquare = format == ShareFormat.square;

    // The card is a fixed-size branded image (on-screen preview and the
    // exported PNG must match pixel-for-pixel), so it must not grow with the
    // device's accessibility text-scale setting the way normal UI does.
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: _buildCard(size, isSquare),
    );
  }

  Widget _buildCard(Size size, bool isSquare) {
    return Container(
      width: size.width,
      height: size.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[AppColors.text, AppColors.inkSoft],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.30),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          // Decorative blurred circles.
          Positioned(
            top: -30,
            right: -30,
            child: _circle(100, AppColors.accent.withValues(alpha: 0.15)),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: _circle(80, AppColors.accent2.withValues(alpha: 0.12)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _header(isSquare),
                _body(isSquare),
                _footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double d, Color color) => Container(
        width: d,
        height: d,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  Widget _header(bool isSquare) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          l10n.appTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFonts.ethiopic(
            size: isSquare ? 15 : 14,
            color: AppColors.bg,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          data.profileLabel.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFonts.body(
            size: 9,
            color: AppColors.onDarkMuted,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _body(bool isSquare) {
    final bool hasHeadline = data.headline != null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (hasHeadline) ...<Widget>[
          _headline(isSquare, data.headline!),
          SizedBox(height: isSquare ? 8 : 18),
        ],
        // The square card has to fit a headline and four bars in 280px, so its
        // bars run a little tighter than the roomier Big Five / story layouts.
        _bars(isSquare, compact: isSquare && hasHeadline),
      ],
    );
  }

  Widget _headline(bool isSquare, String headline) {
    // A short headline is a mark, not a phrase — the Holland code gets the
    // same oversized treatment it has on the results screen. Longer style
    // names stay small enough to wrap onto a second line.
    final bool isShort = headline.characters.length <= 6;
    final double size = isShort
        ? (isSquare ? 30 : 34)
        : (isSquare ? 19 : 22);

    return Text(
      headline,
      maxLines: isShort ? 1 : 2,
      overflow: TextOverflow.ellipsis,
      style: AppFonts.display(
        size: size,
        color: _onCard(data.headlineColor ?? AppColors.accentLight),
        height: 1.15,
      ),
    );
  }

  Widget _bars(bool isSquare, {required bool compact}) {
    final List<ShareStat> stats = data.stats
        .take(format.maxStats(hasHeadline: data.headline != null))
        .toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < stats.length; i++) ...<Widget>[
          _CardBar(
            label: stats[i].label,
            percent: stats[i].percent,
            fraction: stats[i].fraction,
            color: stats[i].color,
            compact: compact,
          ),
          if (i < stats.length - 1)
            SizedBox(height: isSquare ? (compact ? 4 : 5) : 12),
        ],
      ],
    );
  }

  Widget _footer() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 1,
            margin: const EdgeInsets.only(bottom: 6),
            color: Colors.white.withValues(alpha: 0.08),
          ),
          Text(
            l10n.shareCardWhoAreYou,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.body(
              size: 11,
              weight: FontWeight.w600,
              color: AppColors.bg,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            Brand.storeUrl,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.body(
              size: 9,
              color: AppColors.onDarkMuted.withValues(alpha: 0.65),
            ),
          ),
        ],
      ),
    );
  }
}

/// Accents are picked for the cream results screens; the darkest of them (the
/// deep blue) all but vanishes at headline size on the card's near-black
/// gradient, so lift the dark end of the palette toward white.
Color _onCard(Color color) => color.computeLuminance() < 0.16
    ? Color.lerp(color, Colors.white, 0.45)!
    : color;

class _CardBar extends StatelessWidget {
  const _CardBar({
    required this.label,
    required this.percent,
    required this.fraction,
    required this.color,
    this.compact = false,
  });

  final String label;
  final int percent;
  final double fraction;
  final Color color;

  /// Trims a couple of pixels off each bar for the tighter square layout.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final double barHeight = compact ? 5 : 6;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.body(
                  size: 11,
                  weight: FontWeight.w600,
                  color: AppColors.bg,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '$percent%',
              textAlign: TextAlign.right,
              style: AppFonts.body(
                size: 11,
                weight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: compact ? 3 : 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: Stack(
            children: <Widget>[
              Container(
                height: barHeight,
                color: Colors.white.withValues(alpha: 0.08),
              ),
              FractionallySizedBox(
                widthFactor: fraction.clamp(0.0, 1.0),
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
