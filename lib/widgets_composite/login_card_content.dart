import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telehealth/screens/admin/admin_home.dart';
import 'package:telehealth/screens/doctor/doctor_home.dart';
import 'package:telehealth/screens/patient/patient_home.dart';
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

  bool _rememberCredentials=false;
  bool _loggingIn=false;

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
          CustomTextField(label: "Email", textInputType: TextInputType.emailAddress, hintText: "someone@example.com", onChanged: (value){},),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(label: "Password", obscureText: true, onChanged: (value){},),
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
                onPressed: (){
                  // setState(() {
                  //   _loggingIn=!_loggingIn;
                  // });
                  if(_userType==UserType.patient){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientHome()));
                  }else if(_userType==UserType.doctor){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorHome()));
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHome()));
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

