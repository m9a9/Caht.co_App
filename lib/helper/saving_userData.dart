import 'package:shared_preferences/shared_preferences.dart';

class SavingUserData {
  static String userLoggedInKey = 'LoggedInKey';
  static String userNameKey = 'UserNameKey';
  static String userEmailKey = 'UserEmailKey';

//Todo:: Saving User Data Function th SF
  static Future<bool> saveLoggesInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserName(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

//Todo::getting User Data Function th SF
  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences rf = await SharedPreferences.getInstance();
    return rf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences rf = await SharedPreferences.getInstance();
    return rf.getString(userNameKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences rf = await SharedPreferences.getInstance();
    return rf.getString(userEmailKey);
  }
}
