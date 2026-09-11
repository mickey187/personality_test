import 'package:flutter/material.dart';

/// One labelled bar on the share card.
class ShareStat {
  const ShareStat({
    required this.label,
    required this.percent,
    required this.fraction,
    required this.color,
  });

  final String label;
  final int percent;
  final double fraction;
  final Color color;
}

/// Everything the branded share card needs, independent of which test produced
/// it. Each results screen maps its own result into this shape so all tests
/// export the same image-first share (Telegram / Instagram) rather than text.
class ShareCardData {
  const ShareCardData({
    required this.profileLabel,
    required this.stats,
    required this.shareText,
    this.headline,
    this.headlineColor,
  });

  /// Small eyebrow under the app title — the test's name, e.g. "Love Language".
  final String profileLabel;

  /// The headline result, when the test has a single top answer (love language,
  /// leadership style, Holland code, EQ score). Big Five has none — its five
  /// bars are the result.
  final String? headline;

  /// Accent for [headline]; lightened automatically when too dark for the card.
  final Color? headlineColor;

  /// Bars shown under the headline, strongest first.
  final List<ShareStat> stats;

  /// Caption that accompanies the image in the OS share sheet.
  final String shareText;
}
