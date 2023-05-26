import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseServices {
  final String? uId;

  DataBaseServices({this.uId});

// define two refrences to users and groups
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groupsCollection =
      FirebaseFirestore.instance.collection('groups');

// Saving  user data function

  Future SavingUserData(String? fullName, String? email) async {
    return await userCollection.doc(uId).set({
      'fullName': fullName,
      'email': email,
      'groups': [],
      'profilePic': '',
      'uId': uId,
    });
  }

  Future getUserData(String email) async {
    QuerySnapshot querySnapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return querySnapshot;
  }
}
