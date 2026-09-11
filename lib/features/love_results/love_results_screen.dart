import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/theme/app_theme.dart';
import '../../data/love_content.dart';
import '../../data/models/love.dart';
import '../../data/test_catalog.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../share/share_card_data.dart';
import '../widgets/ranked_results_view.dart';

/// Love Language results — a thin wrapper over [RankedResultsView].
class LoveResultsScreen extends StatelessWidget {
  const LoveResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String lang = Localizations.localeOf(context).languageCode;
    final LoveResult? result = AppScope.loveResultsOf(context).current;

    if (result == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(Routes.landing);
      });
      return const Scaffold();
    }

    final List<LoveLanguage> ranked = result.ranked;
    final List<LoveLanguage> top2 = ranked.take(2).toList();

    return RankedResultsView(
      title: l10n.loveResultsTitle,
      subtitle: l10n.loveResultsSubtitle,
      heroLabel: l10n.lovePrimaryLabel,
      heroValue: result.primary.label(l10n),
      heroColor: kLoveColors[result.primary]!,
      heroDescription: kLoveContent[result.primary]!.description.resolve(lang),
      bars: <RankedBar>[
        for (final LoveLanguage l in ranked)
          RankedBar(
            label: l.label(l10n),
            percent: result.percentFor(l),
            fraction: result.fractionFor(l),
            color: kLoveColors[l]!,
          ),
      ],
      section1Title: l10n.loveMeaningTitle,
      section1: <RankedCard>[
        for (final LoveLanguage l in top2)
          RankedCard(
            label: l.label(l10n),
            color: kLoveColors[l]!,
            text: kLoveContent[l]!.description.resolve(lang),
          ),
      ],
      section2Title: l10n.loveTipsTitle,
      section2: <RankedCard>[
        for (final LoveLanguage l in top2)
          RankedCard(
            label: l.label(l10n),
            color: kLoveColors[l]!,
            text: kLoveContent[l]!.tip.resolve(lang),
            icon: Icons.tips_and_updates_outlined,
          ),
      ],
      attribution: l10n.loveAttribution,
      shareData: ShareCardData(
        profileLabel: testById('love')!.name.resolve(lang),
        headline: result.primary.label(l10n),
        headlineColor: kLoveColors[result.primary]!,
        stats: <ShareStat>[
          for (final LoveLanguage l in ranked)
            ShareStat(
              label: l.label(l10n),
              percent: result.percentFor(l),
              fraction: result.fractionFor(l),
              color: kLoveColors[l]!,
            ),
        ],
        shareText:
            l10n.loveShareText(result.primary.label(l10n), Brand.storeUrl),
      ),
    );
  }
}
