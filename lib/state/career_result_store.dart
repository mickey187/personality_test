import 'package:flutter/foundation.dart';

import '../data/career_result_repository.dart';
import '../data/models/riasec.dart';

/// Holds the Career Aptitude result currently being viewed and mirrors it to
/// the local cache. Parallel to [ResultStore] for the Big Five test.
class CareerResultStore extends ChangeNotifier {
  CareerResultStore(this._repo) {
    _current = _repo.load();
  }

  final CareerResultRepository _repo;
  CareerResult? _current;

  /// The result shown on the career results screen, or `null` if none.
  CareerResult? get current => _current;

  /// Whether a career result exists to revisit.
  bool get hasResult => _current != null;

  /// Records a freshly completed [result] and persists it.
  Future<void> complete(CareerResult result) async {
    _current = result;
    notifyListeners();
    await _repo.save(result);
  }

  /// Clears the cached career result (e.g. on retake).
  Future<void> clear() async {
    _current = null;
    notifyListeners();
    await _repo.clear();
  }
}
