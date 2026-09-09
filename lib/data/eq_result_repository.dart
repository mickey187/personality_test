import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/eq.dart';

const String _lastEqResultKey = 'eq_result_v1';

/// Local-only persistence for the user's most recent EQ result.
///
/// Mirrors [ResultRepository] / [CareerResultRepository]: caches the last
/// [EqResult] as JSON in shared_preferences so it survives an app restart.
class EqResultRepository {
  EqResultRepository(this._prefs);

  final SharedPreferences _prefs;

  /// Persists [result] as the most recent EQ result.
  Future<void> save(EqResult result) async {
    await _prefs.setString(_lastEqResultKey, jsonEncode(result.toJson()));
  }

  /// Returns the last saved EQ result, or `null` if none / unparseable.
  EqResult? load() {
    final String? raw = _prefs.getString(_lastEqResultKey);
    if (raw == null) return null;
    try {
      return EqResult.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      // Corrupt or outdated payload — drop it rather than crash on launch.
      _prefs.remove(_lastEqResultKey);
      return null;
    }
  }

  /// Whether a previous EQ result is cached.
  bool get hasResult => _prefs.containsKey(_lastEqResultKey);

  /// Clears the cached EQ result.
  Future<void> clear() async {
    await _prefs.remove(_lastEqResultKey);
  }
}
