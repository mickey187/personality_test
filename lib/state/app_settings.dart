import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeModeKey = 'theme_mode';
const String _localeCodeKey = 'locale_code';

/// All locale codes that have ARB translations.
const List<String> allLocaleCodes = <String>['en', 'am'];

/// Locale codes available at runtime / in the language toggle.
List<String> get enabledLocaleCodes => allLocaleCodes;

/// [Locale]s passed to [MaterialApp.supportedLocales].
List<Locale> get enabledLocales =>
    enabledLocaleCodes.map((String code) => Locale(code)).toList();

/// Persists user preferences: UI language and theme.
class AppSettings extends ChangeNotifier {
  /// Creates settings backed by [prefs].
  AppSettings(this._prefs);

  final SharedPreferences _prefs;

  ThemeMode _themeMode = ThemeMode.light;
  // Default to Amharic — the app's primary market is Ethiopia (matches design).
  Locale _locale = const Locale('am');

  /// Current theme mode for [MaterialApp].
  ThemeMode get themeMode => _themeMode;

  /// Whether dark mode is enabled.
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Active UI locale.
  Locale get locale => _locale;

  /// ISO 639-1 language code for [locale].
  String get localeCode => _locale.languageCode;

  /// Loads saved preferences. Safe to call more than once.
  Future<void> load() async {
    final String? savedTheme = _prefs.getString(_themeModeKey);
    _themeMode = switch (savedTheme) {
      'dark' => ThemeMode.dark,
      _ => ThemeMode.light,
    };
    final String? savedLocale = _prefs.getString(_localeCodeKey);
    _locale = _localeFromCode(savedLocale ?? 'am');
    notifyListeners();
  }

  /// Enables or disables dark mode and persists the choice.
  Future<void> setDarkMode(bool enabled) async {
    final ThemeMode next = enabled ? ThemeMode.dark : ThemeMode.light;
    if (next == _themeMode) return;
    _themeMode = next;
    await _prefs.setString(_themeModeKey, enabled ? 'dark' : 'light');
    notifyListeners();
  }

  /// Sets the UI language and persists the choice.
  Future<void> setLocaleCode(String code) async {
    final Locale next = _localeFromCode(code);
    if (next == _locale) return;
    _locale = next;
    await _prefs.setString(_localeCodeKey, next.languageCode);
    notifyListeners();
  }

  /// Toggles between the two supported languages.
  Future<void> toggleLanguage() =>
      setLocaleCode(localeCode == 'am' ? 'en' : 'am');

  Locale _localeFromCode(String code) =>
      enabledLocaleCodes.contains(code) ? Locale(code) : const Locale('en');
}
