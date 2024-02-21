import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:todo_app/repository/profile_repository.dart';
import 'package:todo_app/res/component/input_text_field.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/login/login_view.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

class ProfileController with ChangeNotifier {
  final ProfileRepository _repository = ProfileRepository();

  CollectionReference ref = FirebaseFirestore.instance.collection('User');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future pickImage(BuildContext context, ImageSource imageSource) async {
    final pickedFile =
        await picker.pickImage(source: imageSource, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      // ignore: use_build_context_synchronously
      uploadImage(context);
      notifyListeners();
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage/profileImage${SessionController().user.uid}');

    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    await _repository
        .updateUserProfileUrl(SessionController().user.uid.toString(), newUrl)
        .then((value) {
      Utils.toastMessage('Profile update');
      SessionController().user.profileImage = newUrl;
      setLoading(false);
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  // final ProfileRepository _repository = ProfileRepository();
  final textController = TextEditingController();
  final nameFocusNode = FocusNode();

  //==============update user info func====================//
  Future<void> updateDialogAlert(
    BuildContext context,
    String oldValue,
    String dbFieldId,
    TextInputType textInputType,
  ) {
    textController.text = oldValue;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Update Username')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      myController: textController,
                      focusNode: nameFocusNode,
                      // maxLength: dbFieldId == 'bio' ? 100 : null,
                      onFiledSubmittedValue: (value) {},
                      keyBoardType: textInputType,
                      obscureText: false,
                      hint: 'Enter...',
                      onValidator: (value) {
                        return null;
                      })
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    _repository
                        .updateUserInfo(SessionController().user.uid.toString(),
                            dbFieldId, textController.text.toString())
                        .then((value) {
                      if (dbFieldId == 'name') {
                        SessionController().user.name =
                            textController.text.toString();
                      }
                      textController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  //==============DELETE ACCOUNT FUNC============//
  void deleteAccount(BuildContext context) async {
    FirebaseAuth.instance.currentUser!.delete().then((value) {
      // FirebaseFirestore.instance
      //     .collection('User')
      //     .doc(SessionController().user.uid)
      //     .delete()
      //     .then((value) async {
      SessionController.removeUserFromPreferences();
      SessionController.getUserFromPreference();
      // ignore: use_build_context_synchronously
      PersistentNavBarNavigator.pushNewScreen(context,
          screen: const LoginView(), withNavBar: false);
      Utils.toastMessage('Account deleted successfully');
      // });
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      Navigator.of(context).pop();
    });
  }
}
