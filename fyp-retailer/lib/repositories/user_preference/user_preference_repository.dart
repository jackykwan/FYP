import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKey {
  isFirstTimeLogin,
  locale,
  user,
  biometricId,
  passcodeValidDuration
}

class UserPreferenceRepositoryImpl implements UserPreferenceRepository {
  List<PreferenceKey> whiteList = [
    PreferenceKey.biometricId,
    PreferenceKey.passcodeValidDuration
  ];

  SharedPreferences? _prefs;

  UserPreferenceRepositoryImpl({SharedPreferences? prefs}) : _prefs = prefs;

  @override
  Future<T?> getValue<T>(PreferenceKey key) async {
    final prefs = await getPrefs();
    dynamic value;

    try {
      value = prefs.getBool(key.toString());
      if (value != null) {
        return value;
      }
    } catch (_) {}

    try {
      value = prefs.getString(key.toString());
      if (value != null) {
        return value;
      }
    } catch (_) {}

    try {
      value = prefs.getInt(key.toString());
      if (value != null) {
        return value;
      }
    } catch (_) {}

    try {
      value = prefs.getDouble(key.toString());
      if (value != null) {
        return value;
      }
    } catch (_) {}

    try {
      value = prefs.getStringList(key.toString());
      if (value != null) {
        return value;
      }
    } catch (_) {}

    return null;
  }

  @override
  Future<bool> clearValue(PreferenceKey key) async {
    final prefs = await getPrefs();
    return await prefs.remove(key.toString());
  }

  @override
  Future<bool> clearAll() async {
    bool isSuccess = true;
    PreferenceKey.values
        .where((element) => !whiteList.contains(element))
        .forEach((element) async {
      final isCleared = await clearValue(element);
      if (!isCleared && isSuccess) {
        isSuccess = false;
      }
    });
    return isSuccess;
  }

  @override
  Future<bool> setValue<T>(PreferenceKey key, T value) async {
    final prefs = await getPrefs();
    if (value is String) {
      return await prefs.setString(key.toString(), value);
    } else if (value is double) {
      return await prefs.setDouble(key.toString(), value);
    } else if (value is bool) {
      return await prefs.setBool(key.toString(), value);
    } else if (value is int) {
      return await prefs.setInt(key.toString(), value);
    } else if (value is List<String>) {
      return await prefs.setStringList(key.toString(), value);
    } else if (value is Map<String, dynamic>) {
      return await prefs.setString(key.toString(), jsonEncode(value));
    } else {
      throw "Unsupported type";
    }
  }

  Future<SharedPreferences> getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }
}

abstract class UserPreferenceRepository {
  Future<T?> getValue<T>(PreferenceKey key);
  Future<bool> clearAll();
  Future<bool> clearValue(PreferenceKey key);
  Future<bool> setValue<T>(PreferenceKey key, T value);
}
