import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  setState(() {
                    _loggingIn=!_loggingIn;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8,
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

