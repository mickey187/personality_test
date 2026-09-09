import 'package:flutter/foundation.dart';

import '../data/love_result_repository.dart';
import '../data/models/love.dart';

/// Holds the Love Language result currently being viewed and mirrors it to the
/// local cache.
class LoveResultStore extends ChangeNotifier {
  LoveResultStore(this._repo) {
    _current = _repo.load();
  }

  final LoveResultRepository _repo;
  LoveResult? _current;

  LoveResult? get current => _current;
  bool get hasResult => _current != null;

  Future<void> complete(LoveResult result) async {
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
