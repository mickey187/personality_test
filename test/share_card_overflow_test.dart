import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personality_test/core/theme/app_theme.dart';
import 'package:personality_test/data/models/eq.dart';
import 'package:personality_test/data/models/leadership.dart';
import 'package:personality_test/data/models/learning.dart';
import 'package:personality_test/data/models/love.dart';
import 'package:personality_test/data/models/riasec.dart';
import 'package:personality_test/data/models/trait.dart';
import 'package:personality_test/features/share/share_card.dart';
import 'package:personality_test/features/share/share_card_data.dart';
import 'package:personality_test/l10n/app_localizations.dart';
import 'package:personality_test/l10n/app_localizations_en.dart';
import 'package:personality_test/l10n/app_localizations_am.dart';

/// The Big Five card: five bars, no headline.
ShareCardData _bigFive(AppLocalizations l10n) => ShareCardData(
      profileLabel: l10n.shareCardProfileLabel,
      stats: <ShareStat>[
        for (final Trait t in Trait.values)
          ShareStat(
            label: t.label(l10n),
            percent: 80,
            fraction: 0.8,
            color: kTraitColors[t]!,
          ),
      ],
      shareText: l10n.shareSheetText(Brand.storeUrl),
    );

/// Love Language: a headline plus five bars.
ShareCardData _love(AppLocalizations l10n) => ShareCardData(
      profileLabel: 'Love Language',
      headline: LoveLanguage.wordsOfAffirmation.label(l10n),
      headlineColor: kLoveColors[LoveLanguage.wordsOfAffirmation]!,
      stats: <ShareStat>[
        for (final LoveLanguage l in LoveLanguage.values)
          ShareStat(
            label: l.label(l10n),
            percent: 80,
            fraction: 0.8,
            color: kLoveColors[l]!,
          ),
      ],
      shareText: l10n.loveShareText('x', Brand.storeUrl),
    );

/// Leadership: the widest card — a headline plus six bars.
ShareCardData _leadership(AppLocalizations l10n) => ShareCardData(
      profileLabel: 'Leadership Style',
      headline: LeadershipStyle.visionary.label(l10n),
      headlineColor: kLeadershipColors[LeadershipStyle.visionary]!,
      stats: <ShareStat>[
        for (final LeadershipStyle s in LeadershipStyle.values)
          ShareStat(
            label: s.label(l10n),
            percent: 80,
            fraction: 0.8,
            color: kLeadershipColors[s]!,
          ),
      ],
      shareText: l10n.leadershipShareText('x', Brand.storeUrl),
    );

/// Career: a short Holland-code headline plus six bars.
ShareCardData _career(AppLocalizations l10n) => ShareCardData(
      profileLabel: 'Career Aptitude',
      headline: 'RIA',
      headlineColor: kRiasecColors[RiasecArea.realistic]!,
      stats: <ShareStat>[
        for (final RiasecArea a in RiasecArea.values)
          ShareStat(
            label: a.label(l10n),
            percent: 80,
            fraction: 0.8,
            color: kRiasecColors[a]!,
          ),
      ],
      shareText: l10n.careerShareText('RIA', Brand.storeUrl),
    );

/// EQ: a score + band headline plus four bars.
ShareCardData _eq(AppLocalizations l10n) => ShareCardData(
      profileLabel: 'Emotional Intelligence',
      headline: '82% · ${l10n.eqLevelBalanced}',
      headlineColor: AppColors.accent,
      stats: <ShareStat>[
        for (final EqDimension d in EqDimension.values)
          ShareStat(
            label: d.label(l10n),
            percent: 80,
            fraction: 0.8,
            color: kEqColors[d]!,
          ),
      ],
      shareText: l10n.eqShareText(82, l10n.eqLevelBalanced, Brand.storeUrl),
    );

/// Learning: a headline plus four bars.
ShareCardData _learning(AppLocalizations l10n) => ShareCardData(
      profileLabel: 'Learning Style',
      headline: LearningStyle.readingWriting.label(l10n),
      headlineColor: kLearningColors[LearningStyle.readingWriting]!,
      stats: <ShareStat>[
        for (final LearningStyle s in LearningStyle.values)
          ShareStat(
            label: s.label(l10n),
            percent: 80,
            fraction: 0.8,
            color: kLearningColors[s]!,
          ),
      ],
      shareText: l10n.learningShareText('x', Brand.storeUrl),
    );

/// Every test's card, so a new one can't regress the others' layout.
final Map<String, ShareCardData Function(AppLocalizations)> _cards =
    <String, ShareCardData Function(AppLocalizations)>{
  'big five': _bigFive,
  'love': _love,
  'leadership': _leadership,
  'career': _career,
  'eq': _eq,
  'learning': _learning,
};

Future<void> _pump(
  WidgetTester tester,
  ShareFormat format,
  AppLocalizations l10n,
  ShareCardData data,
) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: ShareCard(data: data, format: format, l10n: l10n),
        ),
      ),
    ),
  );
}

/// Mirrors the FittedBox-wrapped preview in [ShareCardScreen]: the card must
/// keep laying out at its full design size (and never overflow) even when
/// the screen around it is smaller than that design size — e.g. a narrow or
/// short device squeezing the preview area below 280x280.
Future<void> _pumpSqueezed(
  WidgetTester tester,
  ShareFormat format,
  AppLocalizations l10n,
  ShareCardData data,
  Size availableSpace,
) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: availableSpace.width,
            height: availableSpace.height,
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: format.previewSize.width,
                height: format.previewSize.height,
                child: ShareCard(data: data, format: format, l10n: l10n),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// The card must render at a fixed size regardless of the device's
/// accessibility text-scale setting — this reproduces a real-device crash
/// where a larger system font size pushed the footer past the card bottom.
Future<void> _pumpAtTextScale(
  WidgetTester tester,
  ShareFormat format,
  AppLocalizations l10n,
  ShareCardData data,
  double textScale,
) async {
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: ShareCard(data: data, format: format, l10n: l10n),
          ),
        ),
      ),
    ),
  );
}

void main() {
  for (final MapEntry<String, ShareCardData Function(AppLocalizations)> entry
      in _cards.entries) {
    final String name = entry.key;
    final ShareCardData Function(AppLocalizations) build = entry.value;

    for (final ShareFormat format in ShareFormat.values) {
      final String fmt = format == ShareFormat.square ? 'square' : 'story';

      testWidgets('$name $fmt has no overflow - en', (tester) async {
        final AppLocalizations l10n = AppLocalizationsEn();
        await _pump(tester, format, l10n, build(l10n));
        expect(tester.takeException(), isNull);
      });

      testWidgets('$name $fmt has no overflow - am', (tester) async {
        final AppLocalizations l10n = AppLocalizationsAm();
        await _pump(tester, format, l10n, build(l10n));
        expect(tester.takeException(), isNull);
      });

      testWidgets('$name $fmt has no overflow at 1.6x device text scale',
          (tester) async {
        final AppLocalizations l10n = AppLocalizationsAm();
        await _pumpAtTextScale(tester, format, l10n, build(l10n), 1.6);
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets(
    'square format has no overflow when the screen squeezes the preview '
    'below design size (240x240, matches a reported real-device crash)',
    (tester) async {
      final AppLocalizations l10n = AppLocalizationsEn();
      await _pumpSqueezed(
        tester,
        ShareFormat.square,
        l10n,
        _bigFive(l10n),
        const Size(240, 240),
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'story format has no overflow when the screen squeezes the preview '
    'well below design size',
    (tester) async {
      final AppLocalizations l10n = AppLocalizationsAm();
      await _pumpSqueezed(
        tester,
        ShareFormat.story,
        l10n,
        _leadership(l10n),
        const Size(150, 200),
      );
      expect(tester.takeException(), isNull);
    },
  );
}
