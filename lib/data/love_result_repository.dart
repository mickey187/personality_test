import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/love.dart';

const String _lastLoveResultKey = 'love_result_v1';

/// Local-only persistence for the user's most recent Love Language result.
class LoveResultRepository {
  LoveResultRepository(this._prefs);

  final SharedPreferences _prefs;

  Future<void> save(LoveResult result) async {
    await _prefs.setString(_lastLoveResultKey, jsonEncode(result.toJson()));
  }

  LoveResult? load() {
    final String? raw = _prefs.getString(_lastLoveResultKey);
    if (raw == null) return null;
    try {
      return LoveResult.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      _prefs.remove(_lastLoveResultKey);
      return null;
    }
  }

  bool get hasResult => _prefs.containsKey(_lastLoveResultKey);

  Future<void> clear() async {
    await _prefs.remove(_lastLoveResultKey);
  }
}
