// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/utils/routes/route_name.dart';
import 'package:todo_app/view_model/services/session_controller.dart';
import '../../../utils/utils.dart';

class LoginController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  // VARIABLES FOR LOGIN SCREEN
  TextEditingController forgotPasswordEmailController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final forgotPasswordEmailFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool _showPassword = true;
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

//  Function for user login
  void login(BuildContext context) async {
    setLoading(true);
    try {
      //logging user
      final value = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim().toString(),
          password: passwordController.text.trim().toString());

      if (!value.user!.emailVerified) {
        setLoading(false);
        userEmailIsNotVerified(context, value);
      } else {
        //getting user details
        CollectionReference ref = FirebaseFirestore.instance.collection('User');
        ref.doc(value.user!.uid.toString()).get().then((value) async {
          setLoading(false);
          await SessionController.saveUserInPreference(value.data());
          await SessionController.getUserFromPreference();
          emailController.clear();
          passwordController.clear();

          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.dashboardView, (route) => false);
        });
      }
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
      Utils.toastMessage(e.toString());
    }
  }

  //  Function for user login
  void forgotPassword(BuildContext context) async {
    setLoading(true);
    try {
      await auth.sendPasswordResetEmail(
          email: emailController.text.trim().toString());
      Utils.flushBarDoneMessage(
          'Please check your email or spam folder, we have sent your recovery email',
          context);
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

  void userEmailIsNotVerified(context, UserCredential userCredential) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return CupertinoAlertDialog(
    //         title: Center(
    //             child: Text(
    //           'Verify Email',
    //           style: Theme.of(context)
    //               .textTheme
    //               .displayLarge!
    //               .copyWith(fontSize: 18),
    //         )),
    //         content: Text(
    //           'Your email is not verified. We have already sent you an email link to verify your email.',
    //           style: Theme.of(context)
    //               .textTheme
    //               .displayMedium!
    //               .copyWith(fontSize: 16),
    //         ),
    //         actions: [
    //           GestureDetector(
    //               onTap: () {
    //                 userCredential.user!.sendEmailVerification().then((value) {
    //                   Utils.toastMessage('Email sent');
    //                 });
    //                 Navigator.pop(context);
    //               },
    //               child: Text(
    //                 'Send again',
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .displayLarge!
    //                     .copyWith(fontSize: 16),
    //               )),
    //           const SizedBox(
    //             width: 10,
    //           ),
    //           GestureDetector(
    //               onTap: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Text(
    //                 'Close',
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .displayLarge!
    //                     .copyWith(fontSize: 16),
    //               )),
    //           const SizedBox(
    //             width: 10,
    //           ),
    //         ],
    //       );
    //     },
    //   );
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Verify Email'),
        content: const Text(
            'Your email is not verified. We have already sent you an email link to verify your email.'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              userCredential.user!.sendEmailVerification().then((value) {
                Utils.flushBarDoneMessage('Email sent', context);
                Navigator.pop(context);
              });
            },
            child: const Text('Send again'),
          ),
        ],
      ),
    );
  }
}
