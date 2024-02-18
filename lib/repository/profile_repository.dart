// repository class
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'User';
  //Function for profile url update
  Future<void> updateUserProfileUrl(String userId, String profileUrl) async {
    await _firestore.collection(collectionName).doc(userId).update({
      'profileImage': profileUrl,
    });
  }

  //Function for info update
  Future<void> updateUserInfo(
      String userId, String dataBaseID, String updatedData) async {
    await _firestore.collection(collectionName).doc(userId).update({
      dataBaseID: updatedData,
    });
  }
}
