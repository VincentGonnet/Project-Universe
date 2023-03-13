import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_universe/services/cloud/cloud_user.dart';

class FirebaseCloudStorage {
  final users = FirebaseFirestore.instance.collection("users");

  Future<CloudUser> createUser({
    required String uid,
    required String username,
    required String displayName,
    required String email,
  }) async {
    await users.doc(uid).set({
      "uid": uid,
      "username": username,
      "displayName": displayName,
      "email": email,
    });
    print("Created user $uid");
    return CloudUser(
      uid: uid,
      username: username,
      displayName: displayName,
      email: email,
    );
  }

  // make FirebaseCloudStorage a singleton
  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
  FirebaseCloudStorage._sharedInstance();
}
