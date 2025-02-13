import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/core/core.dart';

/// Implementation of the cache interface using SharedPreferences.
///
/// This class provides methods to store, retrieve, and remove data
/// from the device's local storage.
class SharedPreferencesImpl implements Cache {
  /// Singleton instance of SharedPreferences.
  static SharedPreferences? _prefs;

  /// Ensures SharedPreferences is initialized only once.
  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  Future<dynamic> getData(String key) async {
    await _initPrefs();
    final result = _prefs!.get(key);

    if (result == null) {
      throw CacheException(
        message: 'No value found for key: $key',
        stackTracing: StackTrace.current,
      );
    }

    if (result is String) {
      try {
        return jsonDecode(result);
      } catch (_) {
        return result;
      }
    }

    return result;
  }

  @override
  Future<bool> setData({required CacheParams params}) async {
    await _initPrefs();
    try {
      switch (params.value.runtimeType.toString()) {
        case 'String':
          return await _prefs!.setString(params.key, params.value);
        case 'int':
          return await _prefs!.setInt(params.key, params.value);
        case 'bool':
          return await _prefs!.setBool(params.key, params.value);
        case 'double':
          return await _prefs!.setDouble(params.key, params.value);
        case 'List<String>':
          return await _prefs!.setStringList(params.key, params.value);
        default:
          return await _prefs!.setString(params.key, jsonEncode(params.value));
      }
    } catch (e, stackTrace) {
      throw CacheException(
          message:
              'Failed to save data for key: ${params.key}. Error: ${e.toString()}',
          stackTracing: stackTrace);
    }
  }

  @override
  Future<bool> removeData(String key) async {
    await _initPrefs();
    try {
      return await _prefs!.remove(key);
    } catch (e, stackTrace) {
      throw CacheException(
        message: 'Failed to remove data for key: $key. Error: ${e.toString()}',
        stackTracing: stackTrace,
      );
    }
  }

  @override
  Future<bool> clearAll() async {
    await _initPrefs();
    try {
      return await _prefs!.clear();
    } catch (e, stackTrace) {
      throw CacheException(
        message: 'Failed to clear all data. Error: ${e.toString()}',
        stackTracing: stackTrace,
      );
    }
  }
}
