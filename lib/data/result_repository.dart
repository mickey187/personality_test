import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/test_result.dart';

const String _lastResultKey = 'last_result_v1';

/// Local-only persistence for the user's most recent completed result.
///
/// v1 has no backend; we simply cache the last [TestResult] as JSON in
/// shared_preferences so the user can revisit it after closing the app.
class ResultRepository {
  ResultRepository(this._prefs);

  final SharedPreferences _prefs;

  /// Persists [result] as the most recent result.
  Future<void> save(TestResult result) async {
    await _prefs.setString(_lastResultKey, jsonEncode(result.toJson()));
  }

  /// Returns the last saved result, or `null` if none / if it can't be parsed.
  TestResult? load() {
    final String? raw = _prefs.getString(_lastResultKey);
    if (raw == null) return null;
    try {
      return TestResult.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      // Corrupt or outdated payload — drop it rather than crash on launch.
      _prefs.remove(_lastResultKey);
      return null;
    }
  }

  /// Whether a previous result is cached.
  bool get hasResult => _prefs.containsKey(_lastResultKey);

  /// Clears the cached result.
  Future<void> clear() async {
    await _prefs.remove(_lastResultKey);
  }
}
