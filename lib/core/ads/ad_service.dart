import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Loads and shows the single interstitial the app uses (gating the results
/// reveal — see PRD; placing it right after the quiz ends is the natural
/// transition point).
///
/// Automatically uses Google's TEST ad unit id in debug/profile builds and
/// the real AdMob unit id in release builds, so there's no manual swap
/// before shipping.
class AdService {
  AdService._();
  static final AdService instance = AdService._();

  /// Google-provided Android interstitial test unit.
  static const String _testInterstitialId =
      'ca-app-pub-3940256099942544/1033173712';

  static const String _prodInterstitialId =
      'ca-app-pub-9648776500549891/6191991877';

  String get _adUnitId =>
      kReleaseMode ? _prodInterstitialId : _testInterstitialId;

  bool _initialized = false;
  InterstitialAd? _interstitial;

  /// Runs the UMP consent flow, then initialises the Mobile Ads SDK and
  /// preloads the interstitial. Safe to call multiple times; never throws to
  /// the caller.
  ///
  /// Google requires consent to be gathered (EEA/UK/Swiss users) before ads
  /// are requested; `canRequestAds()` reflects that requirement so we never
  /// call `MobileAds.instance.initialize()` ahead of it.
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    try {
      await _gatherConsent();
      if (!await ConsentInformation.instance.canRequestAds()) return;
      await MobileAds.instance.initialize();
      _load();
    } catch (_) {
      // Ads are non-essential — swallow init failures.
    }
  }

  Future<void> _gatherConsent() {
    final Completer<void> done = Completer<void>();
    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () async {
        await ConsentForm.loadAndShowConsentFormIfRequired((FormError? _) {});
        if (!done.isCompleted) done.complete();
      },
      (FormError _) {
        if (!done.isCompleted) done.complete();
      },
    );
    return done.future;
  }

  /// Whether the user's consent choice means a "Privacy options" entry point
  /// must be shown somewhere in the app (e.g. the About screen).
  Future<bool> isPrivacyOptionsRequired() async {
    final PrivacyOptionsRequirementStatus status =
        await ConsentInformation.instance.getPrivacyOptionsRequirementStatus();
    return status == PrivacyOptionsRequirementStatus.required;
  }

  /// Re-opens the UMP privacy options form so the user can change consent.
  Future<void> showPrivacyOptionsForm() {
    final Completer<void> done = Completer<void>();
    ConsentForm.showPrivacyOptionsForm((FormError? _) {
      if (!done.isCompleted) done.complete();
    });
    return done.future;
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
