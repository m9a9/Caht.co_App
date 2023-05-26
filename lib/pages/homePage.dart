import 'package:chatco_app/Services/auth_services.dart';
import 'package:chatco_app/constatns.dart';
import 'package:chatco_app/helper/saving_userData.dart';
import 'package:chatco_app/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  static String id = 'HomePage';
  SavingUserData? userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          'Groups',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, HomePage.id);
              },
              icon: Icon(Icons.search)),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white.withOpacity(0.5),
        semanticLabel: 'Account',
        shadowColor: kPrimaryColor,
        surfaceTintColor: Colors.deepOrange,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Account'),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('Groups'),
              leading: Icon(Icons.group),
            ),
            ListTile(
              title: Text('SignOut'),
              leading: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await AuthServices().signOut();
              Navigator.pushNamed(context, LogInPage.id);
            },
            child: Text('Log Out')),
      ),
    );
  }
}
