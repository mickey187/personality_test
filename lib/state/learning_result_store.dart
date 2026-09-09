import 'package:flutter/foundation.dart';

import '../data/learning_result_repository.dart';
import '../data/models/learning.dart';

/// Holds the Learning Style result currently being viewed and mirrors it to the
/// local cache.
class LearningResultStore extends ChangeNotifier {
  LearningResultStore(this._repo) {
    _current = _repo.load();
  }

  final LearningResultRepository _repo;
  LearningResult? _current;

  LearningResult? get current => _current;
  bool get hasResult => _current != null;

  Future<void> complete(LearningResult result) async {
    _current = result;
    notifyListeners();
    await _repo.save(result);
  }

  Future<void> clear() async {
    _current = null;
    notifyListeners();
    await _repo.clear();
  }
}
