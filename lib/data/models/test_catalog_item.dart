import 'package:flutter/material.dart';

import 'question.dart';

/// A test offered on the home screen.
///
/// Only [available] tests can be opened and started; the rest render as
/// "coming soon" placeholders. The bilingual copy (name, category, blurb and
/// meta) is structured domain content, so — like [Question] and trait
/// descriptions — it lives here in Dart rather than in ARB and resolves with
/// the active language code.
class TestCatalogItem {
  const TestCatalogItem({
    required this.id,
    required this.icon,
    required this.color,
    required this.available,
    required this.name,
    required this.category,
    required this.description,
    required this.duration,
    required this.questions,
  });

  /// Stable identifier used in routes.
  final String id;

  /// Icon shown in the home card and detail hero.
  final IconData icon;

  /// Accent colour for this test's icon circle.
  final Color color;

  /// Whether the test can be taken now. `false` shows a "coming soon" state.
  final bool available;

  final LocalizedText name;
  final LocalizedText category;
  final LocalizedText description;
  final LocalizedText duration;
  final LocalizedText questions;
}
