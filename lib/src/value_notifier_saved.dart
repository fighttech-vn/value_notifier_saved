import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValueNotifierSaved<T> {
  final String key;
  final SharedPreferences _sharedPreferences;
  final T? defaultValue;

  ValueNotifierSaved(
    this.key,
    this._sharedPreferences, {
    this.defaultValue,
  }) {
    final tType = T.toString();
    if (tType.contains('?') == false) {
      assert(defaultValue != null, 'must set default value for strong type');
    }

    if (tType == 'String?' || tType == 'String') {
      var val = _sharedPreferences.getString(key);
      if (val == null && tType == 'String') {
        val = defaultValue as String;
      }
      _controller = ValueNotifier<T>(val as T);
    } else if (tType == 'int?' || tType == 'int') {
      var val = _sharedPreferences.getInt(key);
      if (val == null && tType == 'int') {
        val = defaultValue as int;
      }
      _controller = ValueNotifier<T>(val as T);
    } else if (tType == 'double?' || tType == 'double') {
      var val = _sharedPreferences.getDouble(key);
      if (val == null && tType == 'double') {
        val = defaultValue as double;
      }
      _controller = ValueNotifier<T>(val as T);
    } else if (tType == 'bool?' || tType == 'bool') {
      var val = _sharedPreferences.getBool(key);
      if (val == null && tType == 'bool') {
        val = defaultValue as bool;
      }
      _controller = ValueNotifier<T>(val as T);
    }

    _controller.addListener(() {
      _save(_controller.value);
    });
  }

  late ValueNotifier<T> _controller;

  void _save(T val) {
    _controller.value = val;

    final tType = T.toString();
    if (tType == 'String?' || tType == 'String') {
      _sharedPreferences.setString(key, val as String);
    } else if (tType == 'int?' || tType == 'int') {
      _sharedPreferences.setInt(key, val as int);
    } else if (tType == 'double?' || tType == 'double') {
      _sharedPreferences.setDouble(key, val as double);
    } else if (tType == 'bool?' || tType == 'bool') {
      _sharedPreferences.setBool(key, val as bool);
    }
  }

  T get saved => _controller.value;
  ValueNotifier<T> get controller => _controller;
}
