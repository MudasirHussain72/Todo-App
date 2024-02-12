import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/view_model/services/shared_preference.dart';

//singleton class
class SessionController {
  static final SessionController _session = SessionController._internel();
  bool? isLogin;
  late UserModel user;

  factory SessionController() {
    return _session;
  }

  SessionController._internel() {
    // here we can initialize the values
    isLogin = false;
  }

  // saving data into shared prefrences
  static Future<void> saveUserInPreference(dynamic user) async {
    SharedPreferenceClass.setValueBoolen('isLogin', true);
    SharedPreferenceClass.setValue('user', jsonEncode(user));
  }

  //getting User Data from shared Preference
  static Future<void> getUserFromPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dynamic userData = prefs.getString("user");

    if (userData != null) {
      // print(userData);
      // var data = jsonDecode(userData);
      SessionController().user = UserModel.fromJson(jsonDecode(userData));
    } else {
      SessionController().user = UserModel(uid: '');
    }

    SessionController().isLogin = prefs.getBool('isLogin') ?? false;
  }

  //removing User Data from Prefrence
  static Future<void> removeUserFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', '');
    prefs.setBool('isLogin', false);
  }
}