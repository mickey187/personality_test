import 'package:flutter/foundation.dart';

import '../data/mbti_result_repository.dart';
import '../data/models/mbti.dart';

/// Holds the personality-type result currently being viewed and mirrors it to
/// the local cache.
class MbtiResultStore extends ChangeNotifier {
  MbtiResultStore(this._repo) {
    _current = _repo.load();
  }

  final MbtiResultRepository _repo;
  MbtiResult? _current;

  MbtiResult? get current => _current;
  bool get hasResult => _current != null;

  Future<void> complete(MbtiResult result) async {
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
