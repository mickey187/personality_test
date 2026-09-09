import 'package:flutter/foundation.dart';

import '../data/leadership_result_repository.dart';
import '../data/models/leadership.dart';

/// Holds the Leadership Style result currently being viewed and mirrors it to
/// the local cache.
class LeadershipResultStore extends ChangeNotifier {
  LeadershipResultStore(this._repo) {
    _current = _repo.load();
  }

  final LeadershipResultRepository _repo;
  LeadershipResult? _current;

  LeadershipResult? get current => _current;
  bool get hasResult => _current != null;

  Future<void> complete(LeadershipResult result) async {
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
