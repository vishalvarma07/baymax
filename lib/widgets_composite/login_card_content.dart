import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telehealth/global_vars.dart';
import 'package:telehealth/screens/admin/admin_home.dart';
import 'package:telehealth/screens/doctor/doctor_home.dart';
import 'package:telehealth/screens/patient/patient_home.dart';
import 'package:telehealth/services/api_requests/http_services.dart';
import 'package:telehealth/widgets_basic/error_dialog.dart';
import 'package:telehealth/widgets_basic/labeled_radio.dart';
import '../enums.dart';
import '../widgets_basic/custom_text_field.dart';
import '../widgets_basic/material_text_button.dart';

class LoginCardContent extends StatefulWidget {
  final VoidCallback onSignupButtonPress;
  const LoginCardContent({Key? key,required this.onSignupButtonPress}) : super(key: key);

  @override
  State<LoginCardContent> createState() => _LoginCardContentState(this.onSignupButtonPress);
}

class _LoginCardContentState extends State<LoginCardContent> {

  final VoidCallback onSignupButtonPress;
  UserType _userType=UserType.patient;

  _LoginCardContentState(this.onSignupButtonPress);

  final TextEditingController emailFieldController=TextEditingController();
  final TextEditingController passwordFieldController=TextEditingController();

  bool _rememberCredentials=false;
  bool _loggingIn=false;

  void attemptAutoLogin() async{
    if(cookieHashGlobal!="" && userTypeGlobal!="" && usernameGlobal!=""){
      LoginStatus loginStatus=await cookieLogin();
      if(!mounted) return;
      if(loginStatus==LoginStatus.success){
        if(userTypeGlobal=="patient"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientHome()));
        }else if(userTypeGlobal=="doctor"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorHome()));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHome()));
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    attemptAutoLogin();
  }


  @override
  void dispose() {
    attemptAutoLogin();
    emailFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Baymax",style: GoogleFonts.pacifico(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.surfaceTint
          ),),
          const SizedBox(
            height: 12,
          ),
          CustomTextField(label: "Email", controller: emailFieldController, textInputType: TextInputType.emailAddress,  hintText: "someone@example.com", onChanged: (value){},),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(label: "Password", controller: passwordFieldController, obscureText: true, onChanged: (value){},),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Checkbox(
                value: _rememberCredentials,
                onChanged: (value){
                  setState(() {
                    _rememberCredentials=value!;
                  });
                },
              ),
              TextButton(
                child: const Text("Keep me logged in"),
                onPressed: (){
                  setState(() {
                    _rememberCredentials=!_rememberCredentials;
                  });
                },
              ),
              const Spacer(),
              MaterialTextButton(
                buttonName: "Login",
                child: _loggingIn?const CircularProgressIndicator():null,
                onPressed: () async{
                  setState(() {
                    _loggingIn=true;
                  });

                  LoginStatus loginStatus=await login(emailFieldController.text, passwordFieldController.text, _userType, _rememberCredentials);
                  setState(() {
                    _loggingIn=false;
                  });

                  // LoginStatus loginStatus=LoginStatus.success;

                  if(loginStatus==LoginStatus.success){
                    if(!mounted){
                      return;
                    }
                    if(_userType==UserType.patient){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientHome()));
                    }else if(_userType==UserType.doctor){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorHome()));
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHome()));
                    }
                  }else if(loginStatus==LoginStatus.accountBanned){
                    showDialog(
                      context: context,
                      builder: (context)=>ErrorDialog(
                        title: "Account Banned",
                        content: "Your account has been banned by the admin. Contact admin for further details",
                        onPressed: (){
                          Navigator.pop(context);
                        }),
                    );
                  }else{
                    showDialog(
                      context: context,
                      builder: (context)=>ErrorDialog(
                        title: "Login Error",
                        content: "Check your email/password and network connection",
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LabelRadioButton(
                label: "Patient",
                representedValue: UserType.patient,
                currentValue: _userType,
                onChanged: (value){
                  setState(() {
                    _userType=value;
                  });
                },
              ),
              LabelRadioButton(
                label: "Doctor",
                representedValue: UserType.doctor,
                currentValue: _userType,
                onChanged: (value){
                  setState(() {
                    _userType=value;
                  });
                },
              ),
              LabelRadioButton(
                label: "Admin",
                representedValue: UserType.admin,
                currentValue: _userType,
                onChanged: (value){
                  setState(() {
                    _userType=value;
                  });
                },
              ),
            ],
          ),
          TextButton(
            child: const Text("Don't have an account? Sign Up"),
            onPressed: (){
              onSignupButtonPress();
            },
          ),
        ],
      ),
    );
  }
}

