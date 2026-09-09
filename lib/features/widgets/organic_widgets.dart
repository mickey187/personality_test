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
                  color: isAm ? AppColors.bg : AppColors.muted,
                ),
                onTap: () => settings.setLocaleCode('am'),
              ),
              _LangChip(
                label: 'EN',
                selected: !isAm,
                style: AppFonts.body(
                  size: 12,
                  weight: FontWeight.w600,
                  color: !isAm ? AppColors.bg : AppColors.muted,
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

/// Terracotta filled pill — the primary action across the app.
class PrimaryPillButton extends StatelessWidget {
  const PrimaryPillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fontSize = 17,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.30),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (icon != null) ...<Widget>[
                  Icon(icon, size: 18, color: AppColors.bg),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: AppFonts.display(size: fontSize, color: AppColors.bg),
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

/// Outlined pill — secondary action (e.g. Retake).
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
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.text.withValues(alpha: 0.16)),
      ),
      child: InkWell(
        onTap: onPressed,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppFonts.display(size: 15, color: AppColors.text),
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
