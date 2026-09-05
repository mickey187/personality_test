import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personality_test/data/models/test_result.dart';
import 'package:personality_test/data/models/trait.dart';
import 'package:personality_test/features/share/share_card.dart';
import 'package:personality_test/l10n/app_localizations.dart';
import 'package:personality_test/l10n/app_localizations_en.dart';
import 'package:personality_test/l10n/app_localizations_am.dart';

TestResult _result() => TestResult(
      completedAt: DateTime(2026, 1, 1),
      scores: <Trait, TraitScore>{
        for (final Trait t in Trait.values) t: TraitScore(trait: t, raw: 16),
      },
    );

Future<void> _pump(
  WidgetTester tester,
  ShareFormat format,
  AppLocalizations l10n,
) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: ShareCard(result: _result(), format: format, l10n: l10n),
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
                child:
                    ShareCard(result: _result(), format: format, l10n: l10n),
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
  double textScale,
) async {
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: ShareCard(result: _result(), format: format, l10n: l10n),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('square format (Telegram) has no overflow - en', (tester) async {
    await _pump(tester, ShareFormat.square, AppLocalizationsEn());
    expect(tester.takeException(), isNull);
  });

  testWidgets('story format has no overflow - en', (tester) async {
    await _pump(tester, ShareFormat.story, AppLocalizationsEn());
    expect(tester.takeException(), isNull);
  });

  testWidgets('square format (Telegram) has no overflow - am', (tester) async {
    await _pump(tester, ShareFormat.square, AppLocalizationsAm());
    expect(tester.takeException(), isNull);
  });

  testWidgets('story format has no overflow - am', (tester) async {
    await _pump(tester, ShareFormat.story, AppLocalizationsAm());
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'square format has no overflow when the screen squeezes the preview '
    'below design size (240x240, matches a reported real-device crash)',
    (tester) async {
      await _pumpSqueezed(
        tester,
        ShareFormat.square,
        AppLocalizationsEn(),
        const Size(240, 240),
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'story format has no overflow when the screen squeezes the preview '
    'well below design size',
    (tester) async {
      await _pumpSqueezed(
        tester,
        ShareFormat.story,
        AppLocalizationsAm(),
        const Size(150, 200),
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'square format has no overflow at a larger device text scale (1.3x, '
    'matches a reported real-device crash)',
    (tester) async {
      await _pumpAtTextScale(tester, ShareFormat.square, AppLocalizationsAm(), 1.3);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'square format has no overflow at an extreme device text scale (1.6x)',
    (tester) async {
      await _pumpAtTextScale(tester, ShareFormat.square, AppLocalizationsEn(), 1.6);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'story format has no overflow at a larger device text scale (1.3x)',
    (tester) async {
      await _pumpAtTextScale(tester, ShareFormat.story, AppLocalizationsAm(), 1.3);
      expect(tester.takeException(), isNull);
    },
  );
}
