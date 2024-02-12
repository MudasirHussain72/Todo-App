import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/view_model/services/session_controller.dart';
import 'package:todo_app/view_model/services/shared_preference.dart';

class UserPreferences with ChangeNotifier {

  Future<bool> saveUser(var user) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferenceClass.setValue('user', user);
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    notifyListeners();
    return SessionController().user;
  }

  Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    notifyListeners();
    return prefs.clear();
  }

  setStates(){
    notifyListeners();
  }
}