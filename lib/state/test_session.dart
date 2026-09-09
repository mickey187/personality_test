import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/mini_ipip_items.dart';
import '../data/models/question.dart';
import '../data/test_registry.dart';

const String _progressKey = 'in_progress_v1';

/// The default test id used when none has been configured yet.
const String _defaultTestId = 'bigfive';

/// Drives the one-question-per-screen test flow and holds the user's answers.
///
/// A single session serves every test: [configure] swaps in the selected test's
/// item set. In-progress state (test id + answers + position) is persisted to
/// shared_preferences so the user can close the app mid-test and resume the same
/// test. It is cleared on completion or reset.
class TestSession extends ChangeNotifier {
  TestSession(this._prefs, {String? testId, List<TestItem>? items})
      : testId = testId ?? _defaultTestId,
        questions = items ?? kMiniIpipItems;

  final SharedPreferences _prefs;

  /// The catalog id of the test currently loaded (e.g. 'bigfive', 'career').
  String testId;

  /// Items in presentation order for the current test.
  List<TestItem> questions;

  final Map<int, int> _answers = <int, int>{};
  int _currentIndex = 0;

  int get total => questions.length;

  /// Zero-based index of the question currently on screen.
  int get currentIndex => _currentIndex;

  /// 1-based position for display (e.g. "6 / 20").
  int get currentPosition => _currentIndex + 1;

  TestItem get currentQuestion => questions[_currentIndex];

  int get answeredCount => _answers.length;

  /// Fraction answered, 0.0–1.0 (drives the progress bar).
  double get progress => total == 0 ? 0 : answeredCount / total;

  /// Whether every item has an answer.
  bool get isComplete => _answers.length == total;

  /// Whether there is a saved, partially-answered session to resume.
  bool get hasInProgress => _answers.isNotEmpty && !isComplete;

  bool get canGoBack => _currentIndex > 0;

  /// A snapshot of the current answers (id → response 1–5), for scoring.
  Map<int, int> get answers => Map<int, int>.of(_answers);

  /// The response (1–5) previously given for [questionId], or `null`.
  int? responseFor(int questionId) => _answers[questionId];

  /// Loads [items] for [testId] and clears any prior answers. Called when
  /// starting a test fresh (i.e. not resuming an in-progress one).
  Future<void> configure({
    required String testId,
    required List<TestItem> items,
  }) async {
    this.testId = testId;
    questions = items;
    _answers.clear();
    _currentIndex = 0;
    await _persist();
    notifyListeners();
  }

  /// Records [value] (1–5) for the current question and advances to the next
  /// unanswered position (or stays on the last question when finished).
  Future<void> answerCurrent(int value) async {
    _answers[currentQuestion.id] = value;
    if (_currentIndex < total - 1) {
      _currentIndex++;
    }
    await _persist();
    notifyListeners();
  }

  /// Jumps to a specific question index (used by the progress/back controls).
  void goTo(int index) {
    if (index < 0 || index >= total || index == _currentIndex) return;
    _currentIndex = index;
    notifyListeners();
  }

  void goBack() => goTo(_currentIndex - 1);

  /// Restores any saved in-progress session from disk. Call once at startup.
  Future<void> restore() async {
    final String? raw = _prefs.getString(_progressKey);
    if (raw == null) return;
    try {
      final Map<String, dynamic> data =
          jsonDecode(raw) as Map<String, dynamic>;
      testId = data['testId'] as String? ?? _defaultTestId;
      questions = itemsForTest(testId);
      final Map<String, dynamic> saved =
          (data['answers'] as Map).cast<String, dynamic>();
      _answers
        ..clear()
        ..addEntries(saved.entries.map(
          (MapEntry<String, dynamic> e) =>
              MapEntry<int, int>(int.parse(e.key), e.value as int),
        ));
      final int savedIndex = data['index'] as int? ?? 0;
      _currentIndex = savedIndex.clamp(0, total - 1);
      notifyListeners();
    } catch (_) {
      await _prefs.remove(_progressKey);
    }
  }

  /// Clears all answers and returns to the first question.
  Future<void> reset() async {
    _answers.clear();
    _currentIndex = 0;
    await _prefs.remove(_progressKey);
    notifyListeners();
  }

  Future<void> _persist() async {
    await _prefs.setString(
      _progressKey,
      jsonEncode(<String, dynamic>{
        'testId': testId,
        'index': _currentIndex,
        'answers': <String, int>{
          for (final MapEntry<int, int> e in _answers.entries)
            e.key.toString(): e.value,
        },
      }),
    );
  }
}
