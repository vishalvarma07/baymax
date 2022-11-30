import 'package:shared_preferences/shared_preferences.dart';

import '../global_vars.dart';


Future<String> getStoredUname() async{
  final SharedPreferences prefs=await SharedPreferences.getInstance();
  return prefs.getString("uname")??"";
}

Future<String> getStoredLoginToken() async{
  final SharedPreferences prefs=await SharedPreferences.getInstance();
  return prefs.getString("loginToken")??"";
}

Future<String> getStoredUserType() async{
  final SharedPreferences prefs=await SharedPreferences.getInstance();
  return prefs.getString("userType")??"";
}

Future<void> setStoredUname(String uname) async{
  final SharedPreferences prefs=await SharedPreferences.getInstance();
  await prefs.setString("uname", uname);
}

Future<void> setStoredLoginToken(String loginToken) async{
  final SharedPreferences prefs=await SharedPreferences.getInstance();
  await prefs.setString("loginToken", loginToken);
}

Future<void> setStoredUserType(String userType) async{
  final SharedPreferences pref=await SharedPreferences.getInstance();
  await pref.setString("userType", userType);
}

Future<void> clearStoredLoginData() async{
  userTypeGlobal="";
  usernameGlobal="";
  cookieHashGlobal="";
  await setStoredUserType(userTypeGlobal);
  await setStoredLoginToken(cookieHashGlobal);
  await setStoredUname(usernameGlobal);
}

