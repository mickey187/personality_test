import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/organic_widgets.dart';

/// Scientific-integrity / privacy / disclaimer screen.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: BackChevron(onTap: () => context.pop()),
              ),
              const SizedBox(height: 8),
              Text(l10n.aboutTitle, style: AppFonts.ethiopic(size: 22)),
              const SizedBox(height: 16),
              _AboutCard(
                icon: Icons.auto_awesome_rounded,
                iconColor: AppColors.accent,
                title: l10n.aboutScienceTitle,
                body: l10n.aboutScienceDesc,
              ),
              const SizedBox(height: 16),
              _AboutCard(
                icon: Icons.shield_outlined,
                iconColor: AppColors.accent2,
                title: l10n.aboutPrivacyTitle,
                body: l10n.aboutPrivacyDesc,
              ),
              const SizedBox(height: 16),
              _AboutCard(
                icon: Icons.info_outline_rounded,
                iconColor: AppColors.accent,
                title: l10n.aboutDisclaimerTitle,
                body: l10n.aboutDisclaimerDesc,
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  Brand.citation,
                  textAlign: TextAlign.center,
                  style: AppFonts.body(
                    size: 12,
                    color: AppColors.muted,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: AppFonts.body(size: 15, weight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: AppFonts.body(
              size: 14,
              color: AppColors.bodyMuted,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
