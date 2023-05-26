// ignore_for_file: prefer_const_constructors

import 'package:chatco_app/Services/auth_services.dart';
import 'package:chatco_app/constatns.dart';
import 'package:chatco_app/helper/saving_userData.dart';
import 'package:chatco_app/pages/homePage.dart';
import 'package:chatco_app/pages/loginPage.dart';
import 'package:chatco_app/widgets/auth_options.dart';
import 'package:chatco_app/widgets/customButton.dart';
import 'package:chatco_app/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SignUPPage extends StatefulWidget {
  SignUPPage({super.key});
  static String id = 'SignUp';

  @override
  State<SignUPPage> createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  bool _isLoding = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  String? email, password, fullName;

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
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 44),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: kPrimaryColor,
                                  size: 34,
                                )),
                            const SizedBox(
                              width: 70,
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                KAppName,
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/regester.png',
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Text(
                          'Create your Account',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18, color: kPrimaryColor),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField(
                          perfix: Icon(Icons.person_2),
                          hint: 'Full Name',
                          onChange: (data) {
                            fullName = data;
                          },
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
                          title: 'Sign Up',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              registerUser();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '- Or Sign up with - ',
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
                      ],
                    ),
                  ),
                ),
              ));
  }

  Future<void> registerUser() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoding = true;
      });
      await AuthServices()
          .registernewUserWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      )
          .then((value) async {
        if (value == true) {
          // Save user data to shared prefs;
          await SavingUserData.saveUserName(fullName!);
          await SavingUserData.saveUserEmail(email!);
          await SavingUserData.saveLoggesInStatus(true);
          ShowSnakBar(context, 'Success', Colors.green);
          Navigator.pushNamed(context, LogInPage.id);
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
