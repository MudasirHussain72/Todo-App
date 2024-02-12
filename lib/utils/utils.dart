import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/res/colors.dart';

class Utils {
  String showMorningMessage(BuildContext context) {
    DateTime now = DateTime.now();
    if (now.hour <= 3 || now.hour < 12) {
      return 'Good Morning';
    }
    if (now.hour <= 12 || now.hour < 16) {
      return "goodAfterNoon";
    }
    if (now.hour <= 21 || now.hour < 24) {
      return 'goodEvening';
    }
    if (now.hour <= 20 || now.hour < 3) {
      return 'goodEvening';
    }
    return '';
  }

  //helper functions to validate email
  bool emailValidator(String email) {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
    return emailValid;
  }

  static void fieldFocus(
    BuildContext context,
    FocusNode currentNode,
    FocusNode nextFocus,
  ) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black,
        textColor: AppColors.whiteColor,
        fontSize: 16);
  }

  static void flushBarDoneMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          forwardAnimationCurve: Curves.easeIn,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          duration: const Duration(seconds: 3),
          borderRadius: BorderRadius.circular(10),
          backgroundColor: Colors.green.shade400,
          positionOffset: 20,
          icon: const Icon(
            Icons.done_rounded,
            size: 20,
            color: Colors.white,
          ),
        )..show(context));
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          forwardAnimationCurve: Curves.easeIn,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          padding: const EdgeInsets.all(15),
          duration: const Duration(seconds: 3),
          borderRadius: BorderRadius.circular(10),
          backgroundColor: Colors.red.shade400,
          positionOffset: 20,
          icon: const Icon(
            Icons.error,
            size: 20,
            color: Colors.white,
          ),
        )..show(context));
  }
}
