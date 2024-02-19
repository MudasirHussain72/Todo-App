// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/repository/signup_repository.dart';
import 'package:todo_app/utils/routes/route_name.dart';
import 'package:todo_app/view/dashboard/dashboard_view.dart';
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

  //for checking user exists or not?
  static Future<bool> userExists(String? uid) async {
    return (await FirebaseFirestore.instance.collection('User').doc(uid).get())
        .exists;
  }

  // // google sig  in
  // Future<void> loginWithGoogle(BuildContext context) async {
  //   setLoading(true);
  //   try {
  //     //To check internet connectivity
  //     await InternetAddress.lookup('firebase.google.com');
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;
  //     if (googleAuth == null) {
  //       return;
  //     }
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     await FirebaseAuth.instance
  //         .signInWithCredential(credential)
  //         .then((value) async {
  //       SessionController().user.uid = value.user!.uid.toString();
  //       if (await userExists()) {
  //         CollectionReference ref =
  //             FirebaseFirestore.instance.collection('User');
  //         ref.doc(value.user!.uid.toString()).get().then((value) async {
  //           setLoading(false);
  //           await SessionController.saveUserInPreference(value.data());
  //           await SessionController.getUserFromPreference();
  //           emailController.clear();
  //           passwordController.clear();
  //           setLoading(false);
  //           Navigator.pushNamedAndRemoveUntil(
  //               context, RouteName.dashboardView, (route) => false);
  //         });
  //       } else {
  //         UserModel userModel = UserModel(
  //           name: value.user!.displayName.toString(),
  //           email: value.user!.email,
  //           uid: value.user!.uid,
  //           onlineStatus: DateTime.now().microsecondsSinceEpoch.toString(),
  //           isNotificationsEnabled: true,
  //           profileImage: value.user!.photoURL.toString(),
  //         );
  //         // saving user data in database
  //         await SignUpRepository().createUser(value.user!.uid, userModel);
  //         CollectionReference ref =
  //             FirebaseFirestore.instance.collection('User');
  //         await ref.doc(value.user!.uid.toString()).get().then((value) async {
  //           setLoading(false);
  //           await SessionController.saveUserInPreference(value.data());
  //           await SessionController.getUserFromPreference();
  //           emailController.clear();
  //           passwordController.clear();
  //           setLoading(false);
  //           Navigator.pushNamedAndRemoveUntil(
  //               context, RouteName.dashboardView, (route) => false);
  //         });
  //       }
  //     }).onError((error, stackTrace) {
  //       setLoading(false);
  //       Utils.toastMessage(error.toString());
  //     });
  //   } catch (e) {
  //     setLoading(false);
  //     Utils.toastMessage(e.toString());
  //     if (kDebugMode) {
  //       print("Error: $e");
  //     }
  //     return;
  //   }
  // }
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        final GoogleAuthProvider authProvider = GoogleAuthProvider();
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(authProvider);
        final User? user = userCredential.user;

        if (user != null) {
          bool userAlreadyExists = await userExists(user.uid);
          if (!userAlreadyExists) {
            UserModel userModel = UserModel(
              name: user.displayName,
              email: user.email,
              uid: user.uid,
              profileImage: user.photoURL,
            );

            // saving user data in database
            await SignUpRepository().createUser(user.uid, userModel);
            CollectionReference ref =
                FirebaseFirestore.instance.collection('users');
            DocumentSnapshot snapshot = await ref.doc(user.uid).get();
            await SessionController.saveUserInPreference(snapshot.data());
            await SessionController.getUserFromPreference();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardView(),
                ),
                (route) => false);
          } else {
            CollectionReference ref =
                FirebaseFirestore.instance.collection('users');
            DocumentSnapshot snapshot = await ref.doc(user.uid).get();
            await SessionController.saveUserInPreference(snapshot.data());
            await SessionController.getUserFromPreference();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardView(),
                ),
                (route) => false);
          }
        }
        return user;
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        if (googleAuth == null) {
          return null;
        }

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          bool userAlreadyExists = await userExists(user.uid);
          if (!userAlreadyExists) {
            UserModel userModel = UserModel(
              name: user.displayName,
              email: user.email,
              uid: user.uid,
              profileImage: user.photoURL,
            );

            // saving user data in database
            await SignUpRepository().createUser(user.uid, userModel);
            CollectionReference ref =
                FirebaseFirestore.instance.collection('users');
            DocumentSnapshot snapshot = await ref.doc(user.uid).get();
            await SessionController.saveUserInPreference(snapshot.data());
            await SessionController.getUserFromPreference();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardView(),
                ),
                (route) => false);
          } else {
            CollectionReference ref =
                FirebaseFirestore.instance.collection('users');
            DocumentSnapshot snapshot = await ref.doc(user.uid).get();
            await SessionController.saveUserInPreference(snapshot.data());
            await SessionController.getUserFromPreference();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardView(),
                ),
                (route) => false);
          }
        }
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  void userEmailIsNotVerified(context, UserCredential userCredential) {
    if (Platform.isAndroid || kIsWeb) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Center(
                child: Text(
              'Verify Email',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 18),
            )),
            content: Text(
              'Your email is not verified. We have already sent you an email link to verify your email.',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 16),
            ),
            actions: [
              GestureDetector(
                  onTap: () {
                    userCredential.user!.sendEmailVerification().then((value) {
                      Utils.flushBarDoneMessage('Email sent', context);
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    'Send again',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 16),
                  )),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 16),
                  )),
              const SizedBox(
                width: 10,
              ),
            ],
          );
        },
      );
    } else {
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
}
