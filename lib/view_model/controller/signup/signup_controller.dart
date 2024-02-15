// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/repository/signup_repository.dart';
import 'package:todo_app/utils/routes/route_name.dart';
import 'package:todo_app/view_model/services/session_controller.dart';
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
        profileImage: '',
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

  //for checking user exists or not?
  static Future<bool> userExists() async {
    return (await FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get())
        .exists;
  }

  // google sig  in
  Future<void> loginWithGoogle(BuildContext context) async {
    setLoading(true);
    try {
      //To check internet connectivity
      await InternetAddress.lookup('firebase.google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth == null) {
        return;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        SessionController().user.uid = value.user!.uid.toString();
        if (await userExists()) {
          CollectionReference ref =
              FirebaseFirestore.instance.collection('User');
          ref.doc(value.user!.uid.toString()).get().then((value) async {
            setLoading(false);
            await SessionController.saveUserInPreference(value.data());
            await SessionController.getUserFromPreference();
            emailController.clear();
            passwordController.clear();
            setLoading(false);
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.dashboardView, (route) => false);
          });
        } else {
          UserModel userModel = UserModel(
            name: value.user!.displayName.toString(),
            email: value.user!.email,
            uid: value.user!.uid,
            onlineStatus: DateTime.now().microsecondsSinceEpoch.toString(),
            isNotificationsEnabled: true,
            profileImage: value.user!.photoURL.toString(),
          );
          // saving user data in database
          await SignUpRepository().createUser(value.user!.uid, userModel);
          CollectionReference ref =
              FirebaseFirestore.instance.collection('User');
          await ref.doc(value.user!.uid.toString()).get().then((value) async {
            setLoading(false);
            await SessionController.saveUserInPreference(value.data());
            await SessionController.getUserFromPreference();
            emailController.clear();
            passwordController.clear();
            setLoading(false);
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.dashboardView, (route) => false);
          });
        }
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
      if (kDebugMode) {
        print("Error: $e");
      }
      return;
    }
  }
}
