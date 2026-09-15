import 'models/mbti.dart';
import 'models/question.dart';

/// A single personality-type item: a first-person statement the user rates by
/// agreement. Each item is tagged with the single [MbtiPole] it measures —
/// there is no reverse-scoring flag because polarity is already baked into
/// which pole an item belongs to (an "opposite" statement is simply an item
/// for the other pole of the same axis).
class MbtiItem implements TestItem {
  const MbtiItem({required this.id, required this.pole, required this.text});

  /// 1-based presentation number (only a key — order does not affect scoring).
  @override
  final int id;

  /// Which pole this item's "agree" response counts toward.
  final MbtiPole pole;

  /// First-person statement shown to the user, in each supported language.
  @override
  final LocalizedText text;
}

/// The 28 personality-type items — 7 per axis (4/3 split per pole) across the
/// four classic Jungian preference pairs (Extraversion/Introversion,
/// Sensing/Intuition, Thinking/Feeling, Judging/Perceiving).
///
/// These are original statements written for this app, not drawn from any
/// proprietary instrument (the real MBTI®, 16Personalities, Keirsey and
/// Humanmetrics questionnaires are all copyrighted/trademarked) — only the
/// underlying public-domain dichotomy theory is reused. Each item is rated
/// 1-5 (Strongly Disagree -> Strongly Agree). Presentation order interleaves
/// the four axes; the id is only a key, so order does not affect scoring.
///
/// Amharic translations are TODO — `am` currently mirrors `en` as a
/// placeholder pending a follow-up localization pass.
const List<MbtiItem> kMbtiItems = <MbtiItem>[
  // ── Round 1 ──────────────────────────────────────────────────────────────
  MbtiItem(
    id: 1,
    pole: MbtiPole.e,
    text: LocalizedText(
      en: 'I feel more energized after spending time with a group than after '
          'time alone.',
      am: 'I feel more energized after spending time with a group than after '
          'time alone.',
    ),
  ),
  MbtiItem(
    id: 2,
    pole: MbtiPole.s,
    text: LocalizedText(
      en: 'I trust information I can see, touch, or verify directly over a '
          'hunch.',
      am: 'I trust information I can see, touch, or verify directly over a '
          'hunch.',
    ),
  ),
  MbtiItem(
    id: 3,
    pole: MbtiPole.t,
    text: LocalizedText(
      en: 'When making a tough decision, I rely more on logic than on how '
          'people might feel.',
      am: 'When making a tough decision, I rely more on logic than on how '
          'people might feel.',
    ),
  ),
  MbtiItem(
    id: 4,
    pole: MbtiPole.j,
    text: LocalizedText(
      en: 'I like having a clear plan and sticking to it.',
      am: 'I like having a clear plan and sticking to it.',
    ),
  ),

  // ── Round 2 ──────────────────────────────────────────────────────────────
  MbtiItem(
    id: 5,
    pole: MbtiPole.i,
    text: LocalizedText(
      en: 'I need quiet time alone to recharge after a busy day.',
      am: 'I need quiet time alone to recharge after a busy day.',
    ),
  ),
  MbtiItem(
    id: 6,
    pole: MbtiPole.n,
    text: LocalizedText(
      en: 'I enjoy thinking about abstract ideas and future possibilities.',
      am: 'I enjoy thinking about abstract ideas and future possibilities.',
    ),
  ),
  MbtiItem(
    id: 7,
    pole: MbtiPole.f,
    text: LocalizedText(
      en: 'I consider how a decision will affect people’s feelings before I '
          'make it.',
      am: 'I consider how a decision will affect people’s feelings before I '
          'make it.',
    ),
  ),
  MbtiItem(
    id: 8,
    pole: MbtiPole.p,
    text: LocalizedText(
      en: 'I like to keep my options open rather than commit to one plan '
          'early.',
      am: 'I like to keep my options open rather than commit to one plan '
          'early.',
    ),
  ),

  // ── Round 3 ──────────────────────────────────────────────────────────────
  MbtiItem(
    id: 9,
    pole: MbtiPole.e,
    text: LocalizedText(
      en: 'I’d rather think out loud with someone than work through a '
          'problem by myself.',
      am: 'I’d rather think out loud with someone than work through a '
          'problem by myself.',
    ),
  ),
  MbtiItem(
    id: 10,
    pole: MbtiPole.s,
    text: LocalizedText(
      en: 'I pay close attention to details and facts when learning '
          'something new.',
      am: 'I pay close attention to details and facts when learning '
          'something new.',
    ),
  ),
  MbtiItem(
    id: 11,
    pole: MbtiPole.t,
    text: LocalizedText(
      en: 'I value being fair and consistent even if it means being blunt.',
      am: 'I value being fair and consistent even if it means being blunt.',
    ),
  ),
  MbtiItem(
    id: 12,
    pole: MbtiPole.j,
    text: LocalizedText(
      en: 'Unfinished tasks bother me until they’re done.',
      am: 'Unfinished tasks bother me until they’re done.',
    ),
  ),

  // ── Round 4 ──────────────────────────────────────────────────────────────
  MbtiItem(
    id: 13,
    pole: MbtiPole.i,
    text: LocalizedText(
      en: 'I prefer a small, close circle of friends over a large network '
          'of acquaintances.',
      am: 'I prefer a small, close circle of friends over a large network '
          'of acquaintances.',
    ),
  ),
  MbtiItem(
    id: 14,
    pole: MbtiPole.n,
    text: LocalizedText(
      en: 'I often notice patterns or connections that aren’t obvious at '
          'first glance.',
      am: 'I often notice patterns or connections that aren’t obvious at '
          'first glance.',
    ),
  ),
  MbtiItem(
    id: 15,
    pole: MbtiPole.f,
    text: LocalizedText(
      en: 'Keeping harmony in a group matters more to me than being right.',
      am: 'Keeping harmony in a group matters more to me than being right.',
    ),
  ),
  MbtiItem(
    id: 16,
    pole: MbtiPole.p,
    text: LocalizedText(
      en: 'I work well under a loose, flexible schedule.',
      am: 'I work well under a loose, flexible schedule.',
    ),
  ),

  // ── Round 5 ──────────────────────────────────────────────────────────────
  MbtiItem(
    id: 17,
    pole: MbtiPole.e,
    text: LocalizedText(
      en: 'Meeting new people at a social event sounds appealing to me.',
      am: 'Meeting new people at a social event sounds appealing to me.',
    ),
  ),
  MbtiItem(
    id: 18,
    pole: MbtiPole.s,
    text: LocalizedText(
      en: 'I prefer clear, step-by-step instructions over open-ended '
          'guidelines.',
      am: 'I prefer clear, step-by-step instructions over open-ended '
          'guidelines.',
    ),
  ),
  MbtiItem(
    id: 19,
    pole: MbtiPole.t,
    text: LocalizedText(
      en: 'I find it easy to point out flaws in an argument, even if it '
          'upsets someone.',
      am: 'I find it easy to point out flaws in an argument, even if it '
          'upsets someone.',
    ),
  ),
  MbtiItem(
    id: 20,
    pole: MbtiPole.j,
    text: LocalizedText(
      en: 'I prefer to make decisions quickly rather than leave things '
          'open.',
      am: 'I prefer to make decisions quickly rather than leave things '
          'open.',
    ),
  ),

  // ── Round 6 ──────────────────────────────────────────────────────────────
  MbtiItem(
    id: 21,
    pole: MbtiPole.i,
    text: LocalizedText(
      en: 'I often rehearse what I want to say before speaking up in a '
          'group.',
      am: 'I often rehearse what I want to say before speaking up in a '
          'group.',
    ),
  ),
  MbtiItem(
    id: 22,
    pole: MbtiPole.n,
    text: LocalizedText(
      en: 'I get restless doing the same routine tasks over and over.',
      am: 'I get restless doing the same routine tasks over and over.',
    ),
  ),
  MbtiItem(
    id: 23,
    pole: MbtiPole.f,
    text: LocalizedText(
      en: 'I find myself easily moved by other people’s emotions.',
      am: 'I find myself easily moved by other people’s emotions.',
    ),
  ),
  MbtiItem(
    id: 24,
    pole: MbtiPole.p,
    text: LocalizedText(
      en: 'I often decide things at the last minute rather than planning '
          'ahead.',
      am: 'I often decide things at the last minute rather than planning '
          'ahead.',
    ),
  ),

  // ── Round 7 ──────────────────────────────────────────────────────────────
  MbtiItem(
    id: 25,
    pole: MbtiPole.e,
    text: LocalizedText(
      en: 'I find it easy to jump into a conversation with people I’ve just '
          'met.',
      am: 'I find it easy to jump into a conversation with people I’ve just '
          'met.',
    ),
  ),
  MbtiItem(
    id: 26,
    pole: MbtiPole.s,
    text: LocalizedText(
      en: 'I focus on what’s happening right now rather than what might '
          'happen later.',
      am: 'I focus on what’s happening right now rather than what might '
          'happen later.',
    ),
  ),
  MbtiItem(
    id: 27,
    pole: MbtiPole.t,
    text: LocalizedText(
      en: 'I judge a plan mainly by whether it makes sense, not by how it '
          'feels.',
      am: 'I judge a plan mainly by whether it makes sense, not by how it '
          'feels.',
    ),
  ),
  MbtiItem(
    id: 28,
    pole: MbtiPole.j,
    text: LocalizedText(
      en: 'I keep my space and schedule organized.',
      am: 'I keep my space and schedule organized.',
    ),
  ),
];
