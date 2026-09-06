import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Persistent banner shown at the bottom of every screen. Loads its own
/// [BannerAd] and renders nothing until it's ready, so a slow/failed load
/// never leaves a placeholder-sized gap.
///
/// Automatically uses Google's TEST ad unit id in debug/profile builds and
/// the real AdMob unit id in release builds.
class BottomBannerAd extends StatefulWidget {
  const BottomBannerAd({super.key});

  /// Google-provided Android banner test unit.
  static const String _testAdUnitId =
      'ca-app-pub-3940256099942544/6300978111';

  static const String _prodAdUnitId =
      'ca-app-pub-9648776500549891/5902900616';

  static String get _adUnitId =>
      kReleaseMode ? _prodAdUnitId : _testAdUnitId;

  @override
  State<BottomBannerAd> createState() => _BottomBannerAdState();
}

class _BottomBannerAdState extends State<BottomBannerAd> {
  BannerAd? _bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_bannerAd == null) _load();
  }

  Future<void> _load() async {
    final int width = MediaQuery.sizeOf(context).width.truncate();
    final Orientation orientation = MediaQuery.orientationOf(context);
    final AdSize? size = await AdSize
        .getLargeAnchoredAdaptiveBannerAdSizeWithOrientation(
      orientation,
      width,
    );
    if (!mounted) return;

    BannerAd(
      adUnitId: BottomBannerAd._adUnitId,
      size: size ?? AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() => _bannerAd = ad as BannerAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError _) => ad.dispose(),
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BannerAd? ad = _bannerAd;
    if (ad == null) return const SizedBox.shrink();
    return SizedBox(
      width: double.infinity,
      height: ad.size.height.toDouble(),
      child: AdWidget(ad: ad),
    );
  }
}
