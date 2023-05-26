import 'package:chatco_app/constatns.dart';
import 'package:chatco_app/firebase_options.dart';
import 'package:chatco_app/helper/saving_userData.dart';
import 'package:chatco_app/pages/homePage.dart';
import 'package:chatco_app/pages/loginPage.dart';
import 'package:chatco_app/pages/search_page.dart';
import 'package:chatco_app/pages/signUP.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChatcoApp());
}

class ChatcoApp extends StatefulWidget {
  ChatcoApp({super.key});
  @override
  State<ChatcoApp> createState() => _ChatcoAppState();
}

class _ChatcoAppState extends State<ChatcoApp> {
  bool _isLoggedin = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await SavingUserData.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isLoggedin = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LogInPage.id: (context) => LogInPage(),
        SignUPPage.id: (context) => SignUPPage(),
        HomePage.id: (context) => HomePage(),
        SearchPage.id: (context) => SearchPage()
      },
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: _isLoggedin ? HomePage.id : LogInPage.id,
    );
  }
}
