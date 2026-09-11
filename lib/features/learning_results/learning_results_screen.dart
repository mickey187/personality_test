import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/theme/app_theme.dart';
import '../../data/learning_content.dart';
import '../../data/models/learning.dart';
import '../../data/test_catalog.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../share/share_card_data.dart';
import '../widgets/ranked_results_view.dart';

/// Learning Style results — a thin wrapper over [RankedResultsView].
class LearningResultsScreen extends StatelessWidget {
  const LearningResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String lang = Localizations.localeOf(context).languageCode;
    final LearningResult? result = AppScope.learningResultsOf(context).current;

    if (result == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(Routes.landing);
      });
      return const Scaffold();
    }

    final List<LearningStyle> ranked = result.ranked;
    final List<LearningStyle> top2 = ranked.take(2).toList();

    return RankedResultsView(
      title: l10n.learningResultsTitle,
      subtitle: l10n.learningResultsSubtitle,
      heroLabel: l10n.learningPrimaryLabel,
      heroValue: result.primary.label(l10n),
      heroColor: kLearningColors[result.primary]!,
      heroDescription:
          kLearningContent[result.primary]!.description.resolve(lang),
      bars: <RankedBar>[
        for (final LearningStyle s in ranked)
          RankedBar(
            label: s.label(l10n),
            percent: result.percentFor(s),
            fraction: result.fractionFor(s),
            color: kLearningColors[s]!,
          ),
      ],
      section1Title: l10n.learningBestTitle,
      section1: <RankedCard>[
        for (final LearningStyle s in top2)
          RankedCard(
            label: s.label(l10n),
            color: kLearningColors[s]!,
            text: kLearningContent[s]!.description.resolve(lang),
          ),
      ],
      section2Title: l10n.learningTipsTitle,
      section2: <RankedCard>[
        for (final LearningStyle s in top2)
          RankedCard(
            label: s.label(l10n),
            color: kLearningColors[s]!,
            text: kLearningContent[s]!.tip.resolve(lang),
            icon: Icons.tips_and_updates_outlined,
          ),
      ],
      attribution: l10n.learningAttribution,
      shareData: ShareCardData(
        profileLabel: testById('learning')!.name.resolve(lang),
        headline: result.primary.label(l10n),
        headlineColor: kLearningColors[result.primary]!,
        stats: <ShareStat>[
          for (final LearningStyle s in ranked)
            ShareStat(
              label: s.label(l10n),
              percent: result.percentFor(s),
              fraction: result.fractionFor(s),
              color: kLearningColors[s]!,
            ),
        ],
        shareText:
            l10n.learningShareText(result.primary.label(l10n), Brand.storeUrl),
      ),
    );
  }
}
