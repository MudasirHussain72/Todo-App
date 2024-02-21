// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../utils/utils.dart';

class ForgotPasswordController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController forgotPasswordEmailController = TextEditingController();
  final forgotPasswordEmailFocusNode = FocusNode();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //  Function for forgotPassword
  void forgotPassword(BuildContext context) async {
    setLoading(true);
    try {
      await auth.sendPasswordResetEmail(
          email: forgotPasswordEmailController.text.trim().toString());
      Utils.flushBarDoneMessage(
          'Please check your email or spam folder, we have sent your recovery email',
          context,
          6);
      forgotPasswordEmailController.clear();
      setLoading(false);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      setLoading(false);
      if (e.code == 'missing-email') {
        Utils.flushBarErrorMessage('Email address not found', context);
      } else {
        Utils.flushBarErrorMessage(e.message.toString(), context);
      }
    } catch (e) {
      setLoading(false);
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }
}
