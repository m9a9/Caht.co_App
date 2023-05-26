// ignore_for_file: prefer_const_constructors

import 'package:chatco_app/Services/auth_services.dart';
import 'package:chatco_app/Services/dataBase_services.dart';
import 'package:chatco_app/constatns.dart';
import 'package:chatco_app/helper/saving_userData.dart';
import 'package:chatco_app/pages/homePage.dart';
import 'package:chatco_app/pages/signUP.dart';
import 'package:chatco_app/widgets/auth_options.dart';
import 'package:chatco_app/widgets/customButton.dart';
import 'package:chatco_app/widgets/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LogInPage extends StatefulWidget {
  static String id = 'Login';
  LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String? email, password;

  bool _isLoding = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _isLoding
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 33),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            KAppName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Image.asset(
                          'assets/images/login.png',
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                        Text(
                          'Login To your Account',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField(
                          perfix: Icon(Icons.email),
                          hint: 'Email',
                          onChange: (data) {
                            email = data;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField(
                          perfix: Icon(Icons.lock),
                          hint: 'password',
                          obsecure: true,
                          onChange: (data) {
                            password = data;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          title: 'Sign in',
                          onTap: () {
                            login();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '- Or Sign in with - ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AuthOptions(
                                ontap: () {}, image: 'assets/images/fb.png'),
                            AuthOptions(
                                ontap: () {}, image: 'assets/images/gm.png'),
                            AuthOptions(
                                ontap: () {}, image: 'assets/images/tw.png'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Don\' t have an account? ',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, SignUPPage.id);
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Sign UP',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }

  Future login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoding = true;
      });
      await AuthServices()
          .signInwithuserNameandpassword(
        email: email,
        password: password,
      )
          .then((value) async {
        if (value == true) {
          //ToDo:: geetin user data and save it in our sf

          QuerySnapshot querySnapshot = await DataBaseServices(
                  uId: FirebaseAuth.instance.currentUser!.uid)
              .getUserData(email!);
          await SavingUserData.saveUserName(querySnapshot.docs[0]['fullName']);
          await SavingUserData.saveLoggesInStatus(true);
          await SavingUserData.saveUserEmail(email!);

          Navigator.pushNamed(context, HomePage.id);
        } else {
          ShowSnakBar(context, value, Colors.red);
          setState(() {
            _isLoding = false;
          });
        }
      });
    }
  }
}
