// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/repository/signup_repository.dart';
import '../../../utils/utils.dart';

class SignupController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool _showPassword = false;
  bool get showPassword => _showPassword;
  setShowPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //function for registration
  void signup(BuildContext context) async {
    setLoading(true);
    try {
      //creating user
      final value = await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      UserModel userModel = UserModel(
        name: nameController.text.trim(),
        email: value.user!.email,
        uid: value.user!.uid,
        onlineStatus: DateTime.now().microsecondsSinceEpoch.toString(),
        isNotificationsEnabled: true,
      );

      // saving user data in database
      await value.user!.sendEmailVerification();

      await SignUpRepository()
          .createUser(value.user!.uid, userModel)
          .then((value) {
        setLoading(false);

        nameController.clear();
        emailController.clear();
        passwordController.clear();
        Navigator.pop(context);
        Utils.flushBarDoneMessage(
            'Account create successfully, we have sent a verification email to verify your email. Please check inbox or spam folder.',
            context);
        SignupController().dispose();
      }).onError((error, stackTrace) {
        setLoading(false);

        Utils.flushBarErrorMessage(error.toString(), context);
      });
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      if (e.code == 'email-already-in-use') {
        Utils.flushBarErrorMessage(e.message.toString(), context);
      } else if (e.code == 'missing-email') {
        Utils.flushBarErrorMessage('Email address not found', context);
      } else if (e.code == 'wrong-password') {
        Utils.flushBarErrorMessage(e.message.toString(), context);
      } else if (e.code == 'user-not-found') {
        Utils.flushBarErrorMessage(e.message.toString(), context);
      } else {
        Utils.flushBarErrorMessage(e.message.toString(), context);
      }
    } catch (e) {
      setLoading(false);
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }
}
