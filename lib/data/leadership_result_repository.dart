import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/leadership.dart';

const String _lastLeadershipResultKey = 'leadership_result_v1';

/// Local-only persistence for the user's most recent Leadership Style result.
class LeadershipResultRepository {
  LeadershipResultRepository(this._prefs);

  final SharedPreferences _prefs;

  Future<void> save(LeadershipResult result) async {
    await _prefs.setString(
        _lastLeadershipResultKey, jsonEncode(result.toJson()));
  }

  LeadershipResult? load() {
    final String? raw = _prefs.getString(_lastLeadershipResultKey);
    if (raw == null) return null;
    try {
      return LeadershipResult.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      _prefs.remove(_lastLeadershipResultKey);
      return null;
    }
  }

  bool get hasResult => _prefs.containsKey(_lastLeadershipResultKey);

  Future<void> clear() async {
    await _prefs.remove(_lastLeadershipResultKey);
  }
}
