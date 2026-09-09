import 'models/question.dart';

/// Descriptive copy for one dimension of a ranked-profile test (Love Language,
/// Leadership, Learning): a short description and a practical tip, both bilingual.
class RankedContent {
  const RankedContent({required this.description, required this.tip});

  final LocalizedText description;
  final LocalizedText tip;
}
