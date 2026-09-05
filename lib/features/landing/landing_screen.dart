import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../widgets/organic_widgets.dart';

/// Intro screen: brand, one-line pitch, and the call to start the test.
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void _start(BuildContext context) {
    final session = AppScope.sessionOf(context);
    // Resume a partially-answered test if one was saved; otherwise start fresh.
    if (!session.hasInProgress) {
      session.reset();
    }
    context.push(Routes.test);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const _HeroBlob(),
                        const SizedBox(height: 20),
                        Text(
                          Brand.nameAm,
                          textAlign: TextAlign.center,
                          style: AppFonts.ethiopic(size: 32, height: 1.2),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          Brand.tagline,
                          style: AppFonts.display(
                            size: 14,
                            color: AppColors.muted,
                            letterSpacing: 0.42,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 280),
                          child: Text(
                            l10n.landingDesc,
                            textAlign: TextAlign.center,
                            style: AppFonts.body(
                              size: 15,
                              color: AppColors.bodyMuted,
                              height: 1.55,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _MetaRow(
                          icon: Icons.schedule_rounded,
                          label: l10n.landingTime,
                        ),
                        const SizedBox(height: 8),
                        _MetaRow(
                          icon: Icons.auto_awesome_rounded,
                          label: l10n.landingScience,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PrimaryPillButton(
                label: l10n.startButton,
                onPressed: () => _start(context),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.push(Routes.about),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.muted,
                ),
                child: Text(
                  l10n.aboutLink,
                  style: AppFonts.body(size: 13, color: AppColors.muted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The gradient circle with a person glyph at the top of the landing screen.
class _HeroBlob extends StatelessWidget {
  const _HeroBlob();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            AppColors.accent,
            AppColors.accentLight,
            AppColors.accent2,
          ],
          stops: <double>[0.0, 0.5, 1.0],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.25),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: const Icon(Icons.person_rounded, size: 56, color: AppColors.bg),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 16, color: AppColors.muted),
        const SizedBox(width: 6),
        Text(label, style: AppFonts.body(size: 13, color: AppColors.muted)),
      ],
    );
  }
}
