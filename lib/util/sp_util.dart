import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class SpUtil {
  static SpUtil? _singleton;
  static late SharedPreferences _prefs;

  static Future<SpUtil?> getInstance() async {
    if (_singleton == null) {
      var singleton = SpUtil._();
      await singleton._init();
      _singleton = singleton;
    }
    return _singleton;
  }

  SpUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// put object.
  static Future<bool> putObject(String key, Object value) {
    if (_prefs == null) return Future.value(false);
    return _prefs.setString(key, value == null ? '' : json.encode(value));
  }

  /// get obj.
  static T? getObj<T>(String key, T f(Map<String,dynamic> v), {T? defValue}) {
    Map<String,dynamic> map = getObject(key);
    return map == null ? defValue : f(map);
  }

  /// get object.
  static Map<String,dynamic> getObject(String key) {
    String? _data = _prefs.getString(key);
    return (_data == null || _data.isEmpty) ? {}: json.decode(_data);
  }

  /// put object list.
  static Future<bool>? putObjectList(String key, List<Object>? list) {
    List<String>? _dataList = list?.map((value) {
      return json.encode(value);
    }).toList();
    return _prefs.setStringList(key, _dataList!);
  }

  /// get obj list.
  static List<T> getObjList<T>(String key, T f(Map v),
      {List<T> defValue = const []}) {
    List<Map>? dataList = getObjectList(key);
    List<T>? list = dataList?.map((value) {
      return f(value);
    }).toList();
    return list ?? defValue;
  }

  /// get object list.
  static List<Map>? getObjectList(String key) {
    List<String>? dataLis = _prefs.getStringList(key);
    return dataLis?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    }).toList();
  }

  /// get string.
  static String getString(String key, {String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs.getString(key) ?? defValue;
  }

  /// put string.
  static Future<bool> putString(String key, String value) {
    if (_prefs == null) return Future.value(false);
    return _prefs.setString(key, value);
  }

  /// get bool.
  static bool getBool(String key, {bool defValue = false}) {
    if (_prefs == null) return defValue;
    return _prefs.getBool(key) ?? defValue;
  }

  /// put bool.
  static Future<bool> putBool(String key, bool value) {
    if (_prefs == null) return Future.value(false);
    return _prefs.setBool(key, value);
  }

  /// get int.
  static int getInt(String key, {int defValue = 0}) {
    if (_prefs == null) return defValue;
    return _prefs.getInt(key) ?? defValue;
  }

  /// put int.
  static Future<bool> putInt(String key, int value) {
    if (_prefs == null) return Future.value(false);
    return _prefs.setInt(key, value);
  }

  /// get double.
  static double getDouble(String key, {double defValue = 0.0}) {
    if (_prefs == null) return defValue;
    return _prefs.getDouble(key) ?? defValue;
  }

  /// put double.
  static Future<bool> putDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  /// get string list.
  static List<String> getStringList(String key,
      {List<String> defValue = const []}) {
    if (_prefs == null) return defValue;
    return _prefs.getStringList(key) ?? defValue;
  }

  /// put string list.
  static Future<bool> putStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  /// get string.
  static String getStringByTime(String key, {String defValue = ''}) {
    if (_prefs == null) return defValue;
    String value = _prefs.getString(key) ?? defValue;
    if(value !=null && value.contains('##')) {
      var spTime = value.split('##').first;
      var today = DateTime.now(); // 毫秒
      if(spTime !=null && today.isAfter(DateTime.parse(spTime))) {
        return defValue;
      }
    }
    return _prefs.getString(key) ?? defValue;
  }

  /// put string.
  static Future<bool> putStringByTime(String key, String value,{int seconds = 0}) {
    var today = DateTime.now(); // 毫秒
    var spDay = today.add(Duration(seconds: seconds));
    return _prefs.setString(key,  '$spDay##' + value);
  }


  /// get dynamic.
  static dynamic getDynamic(String key, {Object? defValue}) {
    if (_prefs == null) return defValue;
    return _prefs.get(key) ?? defValue;
  }

  /// have key.
  static bool haveKey(String key) {
    return _prefs.getKeys().contains(key);
  }

  /// get keys.
  static Set<String> getKeys() {
    return _prefs.getKeys();
  }

  /// remove.
  static Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  /// clear.
  static Future<bool> clear() {
    return _prefs.clear();
  }

  ///Sp is initialized.
  static bool isInitialized() {
    return _prefs != null;
  }
}
