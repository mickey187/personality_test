import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Loads and shows the single interstitial the app uses (gating the results
/// reveal — see PRD; placing it right after the quiz ends is the natural
/// transition point).
///
/// Uses Google's official TEST ad unit id. Replace [_prodInterstitialId] and
/// the AdMob app id in AndroidManifest.xml with real ids before release.
class AdService {
  AdService._();
  static final AdService instance = AdService._();

  /// Google-provided Android interstitial test unit.
  static const String _testInterstitialId =
      'ca-app-pub-3940256099942544/1033173712';

  /// TODO(release): set the real AdMob interstitial unit id here.
  static const String? _prodInterstitialId = null;

  String get _adUnitId => _prodInterstitialId ?? _testInterstitialId;

  bool _initialized = false;
  InterstitialAd? _interstitial;

  /// Initialises the Mobile Ads SDK and preloads the interstitial. Safe to call
  /// multiple times; never throws to the caller.
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    try {
      await MobileAds.instance.initialize();
      _load();
    } catch (_) {
      // Ads are non-essential — swallow init failures.
    }
  }

  void _load() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) => _interstitial = ad,
        onAdFailedToLoad: (LoadAdError _) => _interstitial = null,
      ),
    );
  }

  /// Shows the interstitial if one is ready, then preloads the next. Always
  /// completes — if no ad is ready it returns immediately and triggers a load,
  /// so the user flow is never blocked.
  Future<void> showInterstitial() async {
    final InterstitialAd? ad = _interstitial;
    if (ad == null) {
      _load();
      return;
    }
    _interstitial = null;

    final Completer<void> done = Completer<void>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _load();
        if (!done.isCompleted) done.complete();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError _) {
        ad.dispose();
        _load();
        if (!done.isCompleted) done.complete();
      },
    );
    await ad.show();
    return done.future;
  }
}
