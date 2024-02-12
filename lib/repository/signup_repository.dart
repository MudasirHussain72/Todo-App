import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/user_model.dart';

class SignUpRepository {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('User');
  // func for createUser
  Future<void> createUser(String id, UserModel userData) async {
    await _userCollection.doc(id).set(userData.toJson());
  }
}
