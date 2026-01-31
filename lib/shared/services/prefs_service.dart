import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper around [SharedPreferences] for easier typed access and defaults.
/// Call [PrefsService.init] once (e.g. in main), then use [Get.find<PrefsService>()] or pass the instance.
class PrefsService {
  PrefsService._(this._prefs);

  final SharedPreferences _prefs;

  /// Initialize and return a [PrefsService]. Call once at startup, then [Get.put] the result.
  static Future<PrefsService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefsService._(prefs);
  }

  // --- String ---
  String? getString(String key) => _prefs.getString(key);

  String getStringOr(String key, String defaultValue) =>
      _prefs.getString(key) ?? defaultValue;

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  // --- Bool ---
  bool? getBool(String key) => _prefs.getBool(key);

  bool getBoolOr(String key, bool defaultValue) =>
      _prefs.getBool(key) ?? defaultValue;

  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  // --- Int ---
  int? getInt(String key) => _prefs.getInt(key);

  int getIntOr(String key, int defaultValue) =>
      _prefs.getInt(key) ?? defaultValue;

  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  // --- Double ---
  double? getDouble(String key) => _prefs.getDouble(key);

  double getDoubleOr(String key, double defaultValue) =>
      _prefs.getDouble(key) ?? defaultValue;

  Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  // --- String list ---
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  List<String> getStringListOr(String key, List<String> defaultValue) =>
      _prefs.getStringList(key) ?? defaultValue;

  Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  // --- Common ---
  bool containsKey(String key) => _prefs.containsKey(key);

  Future<bool> remove(String key) => _prefs.remove(key);

  Future<bool> clear() => _prefs.clear();

  Set<String> get keys => _prefs.getKeys();
}
