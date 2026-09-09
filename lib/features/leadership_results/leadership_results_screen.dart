import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../app_scope.dart';
import '../../core/theme/app_theme.dart';
import '../../data/leadership_content.dart';
import '../../data/models/leadership.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../widgets/ranked_results_view.dart';

/// Leadership Style results — a thin wrapper over [RankedResultsView].
class LeadershipResultsScreen extends StatelessWidget {
  const LeadershipResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final String lang = Localizations.localeOf(context).languageCode;
    final LeadershipResult? result =
        AppScope.leadershipResultsOf(context).current;

    if (result == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(Routes.landing);
      });
      return const Scaffold();
    }

    final List<LeadershipStyle> ranked = result.ranked;
    final List<LeadershipStyle> top2 = ranked.take(2).toList();

    return RankedResultsView(
      title: l10n.leadershipResultsTitle,
      subtitle: l10n.leadershipResultsSubtitle,
      heroLabel: l10n.leadershipPrimaryLabel,
      heroValue: result.dominant.label(l10n),
      heroColor: kLeadershipColors[result.dominant]!,
      heroDescription:
          kLeadershipContent[result.dominant]!.description.resolve(lang),
      bars: <RankedBar>[
        for (final LeadershipStyle s in ranked)
          RankedBar(
            label: s.label(l10n),
            percent: result.percentFor(s),
            fraction: result.fractionFor(s),
            color: kLeadershipColors[s]!,
          ),
      ],
      section1Title: l10n.leadershipStylesTitle,
      section1: <RankedCard>[
        for (final LeadershipStyle s in top2)
          RankedCard(
            label: s.label(l10n),
            color: kLeadershipColors[s]!,
            text: kLeadershipContent[s]!.description.resolve(lang),
          ),
      ],
      section2Title: l10n.leadershipFlexTitle,
      section2: <RankedCard>[
        for (final LeadershipStyle s in top2)
          RankedCard(
            label: s.label(l10n),
            color: kLeadershipColors[s]!,
            text: kLeadershipContent[s]!.tip.resolve(lang),
            icon: Icons.tips_and_updates_outlined,
          ),
      ],
      attribution: l10n.leadershipAttribution,
      onShare: () => SharePlus.instance.share(
        ShareParams(
          text: l10n.leadershipShareText(
              result.dominant.label(l10n), Brand.storeUrl),
        ),
      ),
    );
  }
}
