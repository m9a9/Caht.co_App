import 'package:chatco_app/Services/dataBase_services.dart';
import 'package:chatco_app/helper/saving_userData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

//ToDo:: Register new User function
  Future registernewUserWithEmailAndPassword(
      {String? email, String? password, String? fullName}) async {
    try {
      User user = (await auth.createUserWithEmailAndPassword(
              email: email!, password: password!))
          .user!;
      if (user != null) {
        //ToDo: call the my user update fuction to pass UID th it ;;
        await DataBaseServices(uId: user.uid).SavingUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      return e;
    }
  }

//ToDo:: login  User function
  Future signInwithuserNameandpassword(
      {String? email, String? password}) async {
    try {
      User user = (await auth.signInWithEmailAndPassword(
              email: email!, password: password!))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//ToDo:: log out function
  Future signOut() async {
    try {
      await SavingUserData.saveLoggesInStatus(false);
      await SavingUserData.saveUserEmail("");
      await SavingUserData.saveUserName("");
      await auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
