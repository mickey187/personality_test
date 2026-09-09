import 'package:flutter/foundation.dart';

import '../data/eq_result_repository.dart';
import '../data/models/eq.dart';

/// Holds the EQ result currently being viewed and mirrors it to the local
/// cache. Parallel to [ResultStore] / [CareerResultStore].
class EqResultStore extends ChangeNotifier {
  EqResultStore(this._repo) {
    _current = _repo.load();
  }

  final EqResultRepository _repo;
  EqResult? _current;

  /// The result shown on the EQ results screen, or `null` if none.
  EqResult? get current => _current;

  /// Whether an EQ result exists to revisit.
  bool get hasResult => _current != null;

  /// Records a freshly completed [result] and persists it.
  Future<void> complete(EqResult result) async {
    _current = result;
    notifyListeners();
    await _repo.save(result);
  }

  /// Clears the cached EQ result (e.g. on retake).
  Future<void> clear() async {
    _current = null;
    notifyListeners();
    await _repo.clear();
  }
}
