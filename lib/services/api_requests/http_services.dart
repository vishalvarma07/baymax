import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:telehealth/enums.dart';
import 'package:telehealth/global_vars.dart';
import 'package:crypto/crypto.dart';
import 'package:telehealth/services/shared_prefs.dart';


Future<LoginStatus> login(String inputUsername, String inputPassword, UserType userType, bool rememberCredentials) async{
  String hashedInputPassword=sha256.convert(utf8.encode(inputUsername+inputPassword)).toString();
  String userTypeAsString="patient";
  switch(userType){
    case UserType.patient: userTypeAsString="patient";
    break;
    case UserType.doctor: userTypeAsString="doctor";
    break;
    case UserType.admin: userTypeAsString="admin";
    break;
  }

  try{
    http.Response response=await http.post(Uri.parse("$backendURL/login"),headers: {
      "uname":inputUsername,
      "pwd":hashedInputPassword,
      "user_type":userTypeAsString,
      "login_type":"user",
    });
    if(response.statusCode==201){
      usernameGlobal=inputUsername;
      passwordHashGlobal=hashedInputPassword;
      if(jsonDecode(response.body)['banned']??false){
        return LoginStatus.accountBanned;
      }
      if(rememberCredentials){
        userTypeGlobal=userTypeAsString;
        setStoredUname(usernameGlobal);
        setStoredUserType(userTypeGlobal);
        DateTime now=DateTime.now();
        cookieHashGlobal=sha256.convert(utf8.encode(hashedInputPassword+userTypeGlobal+userTypeAsString+now.month.toString()+now.year.toString())).toString();
        setStoredLoginToken(cookieHashGlobal);

      }
      return LoginStatus.success;
    }else if(response.statusCode==401){
      return LoginStatus.failed;
    }else{
      throw "Error";
    }
  }catch(e){
    return Future.error(e);
  }
}

Future<LoginStatus> cookieLogin() async{
  try{
    http.Response response=await http.post(Uri.parse("$backendURL/login"),headers: {
      "uname": usernameGlobal,
      "pwd": cookieHashGlobal,
      "user_type":userTypeGlobal,
      "login_type":"cookie",
    });
    if(response.statusCode==201){
      dynamic responseBody=jsonDecode(response.body);
      passwordHashGlobal=responseBody['hash'];
      if(responseBody['banned']??false){
        return LoginStatus.accountBanned;
      }
      return LoginStatus.success;
    }else if(response.statusCode==401){
      return LoginStatus.failed;
    }else{
      throw "Error";
    }
  }catch(e){
    return Future.error(e);
  }
}


Future<Map<String,dynamic>> getPatientDashboard() async{
  try{
    http.Response response=await http.get(Uri.parse("$backendURL/dashboard"),headers: {
      "uname":usernameGlobal,
      "pwd":passwordHashGlobal,
      "user_type":"patient",
      "login_type":"user",
    });
    if(response.statusCode!=200){
      throw "Error";
    }
    return jsonDecode(response.body);

  }catch(e){
    return Future.error(e);
  }
}

Future<Map<String,dynamic>> getPatientProfile() async{
  try{
    http.Response response=await http.get(Uri.parse("$backendURL/patientprofile"),headers: {
      "uname":usernameGlobal,
      "pwd":passwordHashGlobal,
      "user_type":"patient",
      "login_type":"user",
    });
    if(response.statusCode!=200){
      throw "Error";
    }
    return jsonDecode(response.body);

  }catch(e){
    return Future.error(e);
  }
}

Future<void> sendPatientProfile(String firstName, String lastName, String phoneNumber, String gender, String height, String weight, String bloodType, String apartmentNumber, String streetName, String zipcode, String state, String dob) async{
  http.Response response=await http.post(Uri.parse("$backendURL/patientprofile"),headers: {
    "uname":usernameGlobal,
    "pwd":passwordHashGlobal,
    "user_type":"patient",
    "login_type":"user",
  },body: {
    "dob": dob,
    "fName": firstName,
    "lName": lastName,
    "phno": phoneNumber,
    "gender": gender,
    "height": height,
    "weight": weight,
    "bloodType": bloodType,
    "apartmentNo": apartmentNumber,
    "streetName": streetName,
    "pincode": zipcode,
    "state": state,
  });
  if(response.statusCode!=200){
    throw "Error";
  }
}

Future<void> changePassword(String oldPassword, String newPassword) async{
  String hashedOldPassword=sha256.convert(utf8.encode(usernameGlobal+oldPassword)).toString();
  String hashedNewPassword=sha256.convert(utf8.encode(usernameGlobal+newPassword)).toString();
  http.Response response=await http.post(Uri.parse("$backendURL/passwordchange"),headers: {
    "uname":usernameGlobal,
    "pwd":passwordHashGlobal,
    "user_type":"patient",
    "login_type":"user",
  },body: {
    "old":hashedOldPassword,
    "new":hashedNewPassword,
  });

  if(response.statusCode!=200){
    throw "Error";
  }
}

Future<void> performSignUp(String firstName, String lastName, String email, String password, String dob) async{
  String hashedPassword=sha256.convert(utf8.encode(email+password)).toString();

  http.Response response=await http.post(Uri.parse("$backendURL/signup"),body: {
    "fName": firstName,
    "lName": lastName,
    "uname": email,
    "pwd": hashedPassword,
    "dob": dob,
  });

  if(response.statusCode!=200){
    throw "Error";
  }

}