import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/test_result.dart';
import '../../data/models/trait.dart';
import '../../l10n/app_localizations.dart';

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
}

/// The branded, dark result card that gets rendered to an image and shared.
/// Deliberately self-contained (no inherited theme) so it renders identically
/// whether shown on screen or captured off-screen.
class ShareCard extends StatelessWidget {
  const ShareCard({
    super.key,
    required this.result,
    required this.format,
    required this.l10n,
  });

  final TestResult result;
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
                _bars(isSquare),
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
          l10n.shareCardProfileLabel.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFonts.body(
            size: 9,
            color: AppColors.muted,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _bars(bool isSquare) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final Trait trait in Trait.values) ...<Widget>[
          _CardBar(
            label: trait.label(l10n),
            percent: result[trait].percent,
            fraction: result[trait].fraction,
            color: kTraitColors[trait]!,
          ),
          if (trait != Trait.values.last)
            SizedBox(height: isSquare ? 5 : 12),
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
            style: AppFonts.body(size: 9, color: AppColors.bodyMuted),
          ),
        ],
      ),
    );
  }
}

class _CardBar extends StatelessWidget {
  const _CardBar({
    required this.label,
    required this.percent,
    required this.fraction,
    required this.color,
  });

  final String label;
  final int percent;
  final double fraction;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: Stack(
            children: <Widget>[
              Container(
                height: 6,
                color: Colors.white.withValues(alpha: 0.08),
              ),
              FractionallySizedBox(
                widthFactor: fraction.clamp(0.0, 1.0),
                child: Container(
                  height: 6,
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
