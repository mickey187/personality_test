import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app_scope.dart';
import '../../core/theme/app_theme.dart';

/// The አማ / EN pill language switch used on the landing and results screens.
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppScope.settingsOf(context);
    // Listen to the settings store so the selected pill updates on toggle.
    // Without this the widget (often used `const`) never rebuilds, leaving the
    // toggle visually stuck even though the app locale actually changes.
    return ListenableBuilder(
      listenable: settings,
      builder: (BuildContext context, _) {
        final bool isAm = settings.localeCode == 'am';
        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadii.pill),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _LangChip(
                label: 'አማ',
                selected: isAm,
                style: AppFonts.ethiopic(
                  size: 12,
                  weight: FontWeight.w600,
                  color: isAm ? AppColors.surface : AppColors.muted,
                ),
                onTap: () => settings.setLocaleCode('am'),
              ),
              _LangChip(
                label: 'EN',
                selected: !isAm,
                style: AppFonts.body(
                  size: 12,
                  weight: FontWeight.w600,
                  color: !isAm ? AppColors.surface : AppColors.muted,
                ),
                onTap: () => settings.setLocaleCode('en'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LangChip extends StatelessWidget {
  const _LangChip({
    required this.label,
    required this.selected,
    required this.style,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final TextStyle style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Text(label, style: style),
      ),
    );
  }
}

/// Filled rounded-rect button — the one primary action style across the app.
class PrimaryPillButton extends StatelessWidget {
  const PrimaryPillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fontSize = 16,
    this.color,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final double fontSize;

  /// Overrides the app-wide accent — used on a test's own screens so the CTA
  /// matches that assessment's colour.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color fill = color ?? AppColors.accent;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.button),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: fill.withValues(alpha: 0.24),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: fill,
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadii.button),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (icon != null) ...<Widget>[
                  Icon(icon, size: 18, color: AppColors.surface),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: AppFonts.display(
                      size: fontSize,
                      weight: FontWeight.w600,
                      color: AppColors.surface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Outlined rounded-rect button — secondary action (e.g. Retake).
class SecondaryPillButton extends StatelessWidget {
  const SecondaryPillButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.button),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppFonts.display(
                size: 15,
                weight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Small circular-ish back chevron used on the question / share / about headers.
class BackChevron extends StatelessWidget {
  const BackChevron({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      icon: const Icon(Icons.chevron_left, color: AppColors.muted, size: 24),
    );
  }
}

/// A rounded-square tinted icon badge — the leading glyph on home cards and
/// inside [InsightCard]/[DimensionRow].
class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    required this.color,
    this.size = 40,
  });

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: Icon(icon, size: size * 0.5, color: color),
    );
  }
}

/// A small tinted pill badge with an icon — "Science-based", "Coming soon".
class SoftBadge extends StatelessWidget {
  const SoftBadge({
    super.key,
    required this.label,
    this.icon,
    this.color = AppColors.muted,
  });

  final String label;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppFonts.body(size: 11, weight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}

/// A muted icon + label pair — duration / question-count meta.
class MetaChip extends StatelessWidget {
  const MetaChip({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14, color: AppColors.muted),
        const SizedBox(width: 4),
        Text(label, style: AppFonts.body(size: 12.5, color: AppColors.muted)),
      ],
    );
  }
}

/// Left-aligned subsection heading — "Your strengths", "Careers that fit", …
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: AppFonts.display(size: 17, weight: FontWeight.w600),
      ),
    );
  }
}

/// The bare animated fill bar shared by every score visualization — used
/// standalone in [DimensionRow] and embedded inside an [InsightCard].
class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.fraction,
    required this.color,
    this.order = 0,
    this.height = 8,
  });

  final double fraction;
  final Color color;
  final int order;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.pill),
      child: Stack(
        children: <Widget>[
          Container(height: height, color: AppColors.text.withValues(alpha: 0.06)),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: fraction.clamp(0.0, 1.0)),
            duration: Duration(milliseconds: 700 + order * 90),
            curve: Curves.easeOutCubic,
            builder: (BuildContext context, double value, _) {
              return FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  height: height,
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

/// One bare (no card background) row in a "full profile" list: leading
/// colour badge, label, trailing percent, and an [AnimatedBar] underneath.
/// Used for the compact ranked lists (Career / EQ / Love / Leadership /
/// Learning).
class DimensionRow extends StatelessWidget {
  const DimensionRow({
    super.key,
    required this.label,
    required this.percent,
    required this.fraction,
    required this.color,
    this.icon,
    this.order = 0,
  });

  final String label;
  final int percent;
  final double fraction;
  final Color color;
  final IconData? icon;
  final int order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            if (icon != null) ...<Widget>[
              IconBadge(icon: icon!, color: color, size: 30),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                label,
                style: AppFonts.body(size: 14.5, weight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$percent%',
              style: AppFonts.body(size: 14.5, weight: FontWeight.w700, color: color),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AnimatedBar(fraction: fraction, color: color, order: order),
      ],
    );
  }
}

/// A white, bordered rounded card: leading colour badge, a label (with an
/// optional small secondary caption and a trailing value), and free-form
/// content below. The one card shape every results screen builds on — trait
/// cards, strength/growth cards, love-language cards, career matches.
class InsightCard extends StatelessWidget {
  const InsightCard({
    super.key,
    required this.color,
    required this.label,
    this.icon,
    this.subLabel,
    this.trailing,
    this.children = const <Widget>[],
  });

  final Color color;
  final String label;
  final IconData? icon;
  final String? subLabel;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconBadge(icon: icon ?? Icons.circle, color: color, size: 32),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      label,
                      style: AppFonts.body(size: 14.5, weight: FontWeight.w600),
                    ),
                    if (subLabel != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          subLabel!,
                          style: AppFonts.body(size: 11.5, color: AppColors.muted),
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          if (children.isNotEmpty) ...<Widget>[
            const SizedBox(height: 12),
            ...children,
          ],
        ],
      ),
    );
  }
}

/// The big identity card at the top of every results screen: an eyebrow
/// label, a headline slot (a score, a Holland code, a radar chart — whatever
/// that test's result is), and an optional description underneath.
class ResultHeroCard extends StatelessWidget {
  const ResultHeroCard({
    super.key,
    required this.eyebrow,
    required this.headline,
    this.description,
  });

  final String eyebrow;
  final Widget headline;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: <Widget>[
          Text(
            eyebrow,
            style: AppFonts.body(
              size: 12.5,
              weight: FontWeight.w600,
              color: AppColors.muted,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 12),
          headline,
          if (description != null) ...<Widget>[
            const SizedBox(height: 12),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: AppFonts.body(size: 13.5, color: AppColors.bodyMuted, height: 1.55),
            ),
          ],
        ],
      ),
    );
  }
}

/// A pentagon radar chart for the Big Five's five trait fractions (0-1),
/// drawn in trait order. No labels on the chart itself — the trait list
/// underneath already carries the labels; this is purely the "shape of you"
/// visual the results brief asked for.
class TraitRadarChart extends StatelessWidget {
  const TraitRadarChart({
    super.key,
    required this.fractions,
    required this.colors,
    this.size = 168,
  });

  /// Five values, 0-1, in a fixed axis order.
  final List<double> fractions;

  /// Five colours, matching [fractions] 1:1 — used for the vertex dots.
  final List<Color> colors;

  final double size;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (BuildContext context, double t, _) {
        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _RadarPainter(
              fractions: fractions.map((double f) => f.clamp(0.0, 1.0) * t).toList(),
              colors: colors,
            ),
          ),
        );
      },
    );
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({required this.fractions, required this.colors});

  final List<double> fractions;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final int n = fractions.length;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.shortestSide / 2 - 10;

    Offset pointAt(int i, double f) {
      final double angle = -math.pi / 2 + (2 * math.pi / n) * i;
      return center + Offset(math.cos(angle), math.sin(angle)) * radius * f;
    }

    // Grid rings.
    final Paint gridPaint = Paint()
      ..color = AppColors.text.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final double ring in <double>[0.34, 0.67, 1.0]) {
      final Path ringPath = Path();
      for (int i = 0; i < n; i++) {
        final Offset p = pointAt(i, ring);
        if (i == 0) {
          ringPath.moveTo(p.dx, p.dy);
        } else {
          ringPath.lineTo(p.dx, p.dy);
        }
      }
      ringPath.close();
      canvas.drawPath(ringPath, gridPaint);
    }
    // Axis spokes.
    for (int i = 0; i < n; i++) {
      canvas.drawLine(center, pointAt(i, 1), gridPaint);
    }

    // Score polygon.
    final Path scorePath = Path();
    for (int i = 0; i < n; i++) {
      final Offset p = pointAt(i, fractions[i]);
      if (i == 0) {
        scorePath.moveTo(p.dx, p.dy);
      } else {
        scorePath.lineTo(p.dx, p.dy);
      }
    }
    scorePath.close();

    canvas.drawPath(
      scorePath,
      Paint()..color = AppColors.accent.withValues(alpha: 0.16),
    );
    canvas.drawPath(
      scorePath,
      Paint()
        ..color = AppColors.accent.withValues(alpha: 0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Vertex dots, in each trait's own colour.
    for (int i = 0; i < n; i++) {
      final Offset p = pointAt(i, fractions[i]);
      canvas.drawCircle(p, 4, Paint()..color = colors[i]);
      canvas.drawCircle(
        p,
        4,
        Paint()
          ..color = AppColors.surface
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RadarPainter oldDelegate) =>
      oldDelegate.fractions != fractions || oldDelegate.colors != colors;
}
