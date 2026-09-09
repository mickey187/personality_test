import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/riasec.dart';

const String _lastCareerResultKey = 'career_result_v1';

/// Local-only persistence for the user's most recent Career Aptitude result.
///
/// Mirrors [ResultRepository] for the Big Five test: caches the last
/// [CareerResult] as JSON in shared_preferences so it survives an app restart.
class CareerResultRepository {
  CareerResultRepository(this._prefs);

  final SharedPreferences _prefs;

  /// Persists [result] as the most recent career result.
  Future<void> save(CareerResult result) async {
    await _prefs.setString(_lastCareerResultKey, jsonEncode(result.toJson()));
  }

  /// Returns the last saved career result, or `null` if none / unparseable.
  CareerResult? load() {
    final String? raw = _prefs.getString(_lastCareerResultKey);
    if (raw == null) return null;
    try {
      return CareerResult.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      // Corrupt or outdated payload — drop it rather than crash on launch.
      _prefs.remove(_lastCareerResultKey);
      return null;
    }
  }

  /// Whether a previous career result is cached.
  bool get hasResult => _prefs.containsKey(_lastCareerResultKey);

  /// Clears the cached career result.
  Future<void> clear() async {
    await _prefs.remove(_lastCareerResultKey);
  }
}
