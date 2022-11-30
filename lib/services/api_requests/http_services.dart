import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:telehealth/enums.dart';
import 'package:telehealth/global_vars.dart';
import 'package:crypto/crypto.dart';


Future<LoginStatus> login(String inputUsername, String inputPassword, UserType userType) async{
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
      username=inputUsername;
      passwordHash=hashedInputPassword;
      if(jsonDecode(response.body)['banned']??false){
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
      "uname":username,
      "pwd":passwordHash,
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
      "uname":username,
      "pwd":passwordHash,
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
    "uname":username,
    "pwd":passwordHash,
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
  String hashedOldPassword=sha256.convert(utf8.encode(username+oldPassword)).toString();
  String hashedNewPassword=sha256.convert(utf8.encode(username+newPassword)).toString();
  http.Response response=await http.post(Uri.parse("$backendURL/passwordchange"),headers: {
    "uname":username,
    "pwd":passwordHash,
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