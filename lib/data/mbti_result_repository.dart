import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/mbti.dart';

const String _lastMbtiResultKey = 'mbti_result_v1';

/// Local-only persistence for the user's most recent personality-type result.
class MbtiResultRepository {
  MbtiResultRepository(this._prefs);

  final SharedPreferences _prefs;

  Future<void> save(MbtiResult result) async {
    await _prefs.setString(_lastMbtiResultKey, jsonEncode(result.toJson()));
  }

  MbtiResult? load() {
    final String? raw = _prefs.getString(_lastMbtiResultKey);
    if (raw == null) return null;
    try {
      return MbtiResult.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      _prefs.remove(_lastMbtiResultKey);
      return null;
    }
  }

  bool get hasResult => _prefs.containsKey(_lastMbtiResultKey);

  Future<void> clear() async {
    await _prefs.remove(_lastMbtiResultKey);
  }
}
