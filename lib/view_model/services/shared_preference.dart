import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {
  static setValue(String keys, String values) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keys, values);
  }

  static setValueBoolen(String keys, bool values) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(keys, values);
  }

  static clearVlaue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
