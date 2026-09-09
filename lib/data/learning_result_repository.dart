import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/learning.dart';

const String _lastLearningResultKey = 'learning_result_v1';

/// Local-only persistence for the user's most recent Learning Style result.
class LearningResultRepository {
  LearningResultRepository(this._prefs);

  final SharedPreferences _prefs;

  Future<void> save(LearningResult result) async {
    await _prefs.setString(_lastLearningResultKey, jsonEncode(result.toJson()));
  }

  LearningResult? load() {
    final String? raw = _prefs.getString(_lastLearningResultKey);
    if (raw == null) return null;
    try {
      return LearningResult.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      _prefs.remove(_lastLearningResultKey);
      return null;
    }
  }

  bool get hasResult => _prefs.containsKey(_lastLearningResultKey);

  Future<void> clear() async {
    await _prefs.remove(_lastLearningResultKey);
  }
}
