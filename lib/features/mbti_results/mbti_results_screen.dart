import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/ads/ad_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/mbti_content.dart';
import '../../data/models/mbti.dart';
import '../../data/test_catalog.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../share/share_card_data.dart';
import '../widgets/organic_widgets.dart';

/// Shows the personality-type result: a 4-letter type code, the type's
/// tagline/summary/strengths, a growth tip, and a strength bar per axis.
class MbtiResultsScreen extends StatefulWidget {
  const MbtiResultsScreen({super.key});

  @override
  State<MbtiResultsScreen> createState() => _MbtiResultsScreenState();
}

class _MbtiResultsScreenState extends State<MbtiResultsScreen> {
  bool _revealed = false;
  bool _revealing = false;

  void _retake(BuildContext context) {
    AppScope.sessionOf(context).reset();
    context.go(Routes.landing);
  }

  Future<void> _reveal() async {
    if (_revealing) return;
    setState(() => _revealing = true);
    // Interstitial gates the reveal — same placement as the other tests.
    await AdService.instance.showInterstitial();
    if (!mounted) return;
    setState(() {
      _revealed = true;
      _revealing = false;
    });
  }

  /// Type code as the headline, the four axes as bars.
  ShareCardData _shareData(
    MbtiResult result,
    String lang,
    AppLocalizations l10n,
  ) {
    return ShareCardData(
      profileLabel: testById('mbti')!.name.resolve(lang),
      headline: result.typeCode,
      headlineColor: AppAccents.mbti,
      stats: <ShareStat>[
        for (final MbtiAxis axis in MbtiAxis.values)
          ShareStat(
            label: kMbtiAxisContent[axis]!
                .poleLabel[result.winnerFor(axis)]!
                .resolve(lang),
            percent: result.strengthPercentFor(axis),
            fraction: result.strengthFor(axis),
            color: kMbtiColors[axis]!,
          ),
      ],
      shareText: l10n.mbtiShareText(result.typeCode, Brand.storeUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String lang = Localizations.localeOf(context).languageCode;
    final MbtiResult? result = AppScope.mbtiResultsOf(context).current;
    final Color accent = testById('mbti')?.color ?? AppColors.accent;

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

    final MbtiTypeContent type = kMbtiTypeContent[result.typeCode]!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  QuickIconButton(
                    icon: Icons.ios_share_rounded,
                    color: accent,
                    onPressed: () => context.push(
                      Routes.share,
                      extra: _shareData(result, lang, l10n),
                    ),
                  ),
                  const LanguageToggle(),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      Text(
                        l10n.mbtiResultsTitle,
                        textAlign: TextAlign.center,
                        style: AppFonts.ethiopic(size: 24),
                      ),
                      const SizedBox(height: 20),
                      ResultHeroCard(
                        eyebrow: l10n.mbtiTypeLabel,
                        headline: Column(
                          children: <Widget>[
                            Text(
                              result.typeCode,
                              style: AppFonts.display(size: 42, color: accent),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              type.name.resolve(lang),
                              style: AppFonts.body(
                                size: 15,
                                weight: FontWeight.w700,
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                        description: type.summary.resolve(lang),
                      ),
                      const SizedBox(height: 24),
                      for (int i = 0; i < MbtiAxis.values.length; i++) ...<Widget>[
                        DimensionRow(
                          label: kMbtiAxisContent[MbtiAxis.values[i]]!
                              .poleLabel[result.winnerFor(MbtiAxis.values[i])]!
                              .resolve(lang),
                          percent: result.strengthPercentFor(MbtiAxis.values[i]),
                          fraction: result.strengthFor(MbtiAxis.values[i]),
                          color: kMbtiColors[MbtiAxis.values[i]]!,
                          order: i,
                        ),
                        if (i < MbtiAxis.values.length - 1)
                          const SizedBox(height: 14),
                      ],
                      const SizedBox(height: 26),
                      SectionTitle(l10n.mbtiTraitsTitle),
                      const SizedBox(height: 12),
                      for (final strength in type.strengths) ...<Widget>[
                        InsightCard(
                          color: accent,
                          icon: Icons.star_rounded,
                          label: strength.resolve(lang),
                        ),
                        const SizedBox(height: 10),
                      ],
                      const SizedBox(height: 12),
                      SectionTitle(l10n.mbtiGrowthTitle),
                      const SizedBox(height: 12),
                      InsightCard(
                        color: accent,
                        icon: Icons.tips_and_updates_outlined,
                        label: type.growthTip.resolve(lang),
                      ),
                      const SizedBox(height: 20),
                      PrimaryPillButton(
                        label: l10n.shareButton,
                        icon: Icons.ios_share_rounded,
                        color: accent,
                        onPressed: () => context.push(
                          Routes.share,
                          extra: _shareData(result, lang, l10n),
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
            ],
          ),
        ),
      ),
    );
  }
}
