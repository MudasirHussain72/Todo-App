// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/repository/signup_repository.dart';
import 'package:todo_app/utils/routes/route_name.dart';
import 'package:todo_app/view/dashboard/dashboard_view.dart';
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
  static Future<bool> userExists(String? uid) async {
    return (await FirebaseFirestore.instance.collection('User').doc(uid).get())
        .exists;
  }

  // google sig  in
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
              isNotificationsEnabled: true,
              onlineStatus: 'online',
            );

            // saving user data in database
            await SignUpRepository().createUser(user.uid, userModel);
            CollectionReference ref =
                FirebaseFirestore.instance.collection('User');
            await ref.doc(user.uid).get().then((DocumentSnapshot value) async {
              if (value.exists) {
                // Check if the data is not null before accessing it
                if (value.data() != null) {
                  await SessionController.saveUserInPreference(value.data());
                  await SessionController.getUserFromPreference();
                  emailController.clear();
                  passwordController.clear();
                  setLoading(false);
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteName.dashboardView, (route) => false);
                } else {
                  // Handle the case when the data is null
                  print("Error: User data is null");
                }
              } else {
                print("Error: Document does not exist");
              }
            });
          } else {
            CollectionReference ref =
                FirebaseFirestore.instance.collection('User');
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
              isNotificationsEnabled: true,
              onlineStatus: 'online',
            );

            // saving user data in database
            await SignUpRepository().createUser(user.uid, userModel);
            CollectionReference ref =
                FirebaseFirestore.instance.collection('User');
            await ref.doc(user.uid).get().then((DocumentSnapshot value) async {
              if (value.exists) {
                // Check if the data is not null before accessing it
                if (value.data() != null) {
                  await SessionController.saveUserInPreference(value.data());
                  await SessionController.getUserFromPreference();
                  emailController.clear();
                  passwordController.clear();
                  setLoading(false);
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteName.dashboardView, (route) => false);
                } else {
                  // Handle the case when the data is null
                  print("Error: User data is null");
                }
              } else {
                print("Error: Document does not exist");
              }
            });
          } else {
            CollectionReference ref =
                FirebaseFirestore.instance.collection('User');
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
}
