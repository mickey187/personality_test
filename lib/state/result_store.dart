import 'package:flutter/foundation.dart';

import '../data/models/test_result.dart';
import '../data/result_repository.dart';

/// Holds the result currently being viewed and mirrors it to the local cache.
class ResultStore extends ChangeNotifier {
  ResultStore(this._repo) {
    _current = _repo.load();
  }

  final ResultRepository _repo;
  TestResult? _current;

  /// The result shown on the results / share screens, or `null` if none.
  TestResult? get current => _current;

  /// Whether a result exists to revisit from the landing screen.
  bool get hasResult => _current != null;

  /// Records a freshly completed [result] and persists it.
  Future<void> complete(TestResult result) async {
    _current = result;
    notifyListeners();
    await _repo.save(result);
  }

  /// Clears the cached result (e.g. on retake).
  Future<void> clear() async {
    _current = null;
    notifyListeners();
    await _repo.clear();
  }
}
