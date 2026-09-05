import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app_scope.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/test_result.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../widgets/organic_widgets.dart';
import 'share_card.dart';

/// Preview + export of the branded result card.
class ShareCardScreen extends StatefulWidget {
  const ShareCardScreen({super.key});

  @override
  State<ShareCardScreen> createState() => _ShareCardScreenState();
}

class _ShareCardScreenState extends State<ShareCardScreen> {
  final GlobalKey _cardKey = GlobalKey();
  ShareFormat _format = ShareFormat.square;
  bool _sharing = false;

  Future<void> _share(AppLocalizations l10n) async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      final Uint8List bytes = await _captureCard();
      final Directory dir = await getTemporaryDirectory();
      final File file = File(
        '${dir.path}/who_am_i_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(bytes);

      await SharePlus.instance.share(
        ShareParams(
          files: <XFile>[XFile(file.path, mimeType: 'image/png')],
          text: l10n.shareSheetText(Brand.storeUrl),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not share: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  Future<Uint8List> _captureCard() async {
    final RenderRepaintBoundary boundary =
        _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    // Render at a high pixel ratio so the exported PNG is crisp (~1100px wide).
    final double pixelRatio = 1100 / _format.previewSize.width;
    final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
    final ByteData? data =
        await image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final TestResult? result = AppScope.resultsOf(context).current;
    if (result == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(Routes.landing);
      });
      return const Scaffold();
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BackChevron(onTap: () => context.pop()),
                  Text(
                    l10n.sharePreviewTitle,
                    style: AppFonts.body(size: 14, weight: FontWeight.w600),
                  ),
                  const SizedBox(width: 28),
                ],
              ),
              const SizedBox(height: 16),
              _FormatToggle(
                format: _format,
                onChanged: (ShareFormat f) => setState(() => _format = f),
                l10n: l10n,
              ),
              Expanded(
                child: Center(
                  // FittedBox keeps the card laid out at its full design size
                  // (so it never overflows regardless of screen size) and
                  // only scales the result visually to fit the available
                  // space — the RepaintBoundary still captures it undistorted
                  // at the original size.
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: _format.previewSize.width,
                      height: _format.previewSize.height,
                      child: RepaintBoundary(
                        key: _cardKey,
                        child: ShareCard(
                          result: result,
                          format: _format,
                          l10n: l10n,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              PrimaryPillButton(
                label: _sharing ? '…' : l10n.shareNow,
                icon: Icons.ios_share_rounded,
                fontSize: 16,
                onPressed: () => _share(l10n),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormatToggle extends StatelessWidget {
  const _FormatToggle({
    required this.format,
    required this.onChanged,
    required this.l10n,
  });

  final ShareFormat format;
  final ValueChanged<ShareFormat> onChanged;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _chip(l10n.shareFormatTelegram, ShareFormat.square),
            _chip(l10n.shareFormatStories, ShareFormat.story),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, ShareFormat value) {
    final bool selected = format == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Text(
          label,
          style: AppFonts.body(
            size: 12,
            weight: FontWeight.w600,
            color: selected ? AppColors.bg : AppColors.muted,
          ),
        ),
      ),
    );
  }
}
