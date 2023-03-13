import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_universe/services/cloud/cloud_storage_constants.dart';

class CloudUser {
  final String uid;
  final String username;
  final String displayName;
  final String email;

  const CloudUser({
    required this.uid,
    required this.username,
    required this.displayName,
    required this.email,
  });

  CloudUser.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : uid = snapshot.id,
        username = snapshot.data()[userUsernameFieldName],
        displayName = snapshot.data()[userDisplayNameFieldName],
        email = snapshot.data()[userEmailFieldName] as String;
}
