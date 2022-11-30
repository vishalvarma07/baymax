import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telehealth/services/api_requests/http_services.dart';
import 'package:telehealth/widgets_basic/material_text_button.dart';
import '../widgets_basic/custom_text_field.dart';

class SignupCardContent extends StatefulWidget {
  final VoidCallback onBackButtonPress;

  const SignupCardContent({Key? key,required this.onBackButtonPress}) : super(key: key);

  @override
  State<SignupCardContent> createState() => _SignupCardContentState(onBackButtonPress);
}

class _SignupCardContentState extends State<SignupCardContent> {

  final VoidCallback onBackButtonPress;

  final TextEditingController _firstNameFieldController=TextEditingController();
  final TextEditingController _lastNameFieldController=TextEditingController();
  final TextEditingController _dateOfBirthFieldController=TextEditingController();
  final TextEditingController _emailFieldController=TextEditingController();
  final TextEditingController _passwordFieldController=TextEditingController();
  final TextEditingController _confirmPasswordFieldController=TextEditingController();

  _SignupCardContentState(this.onBackButtonPress);


  @override
  void dispose() {
    _firstNameFieldController.dispose();
    _lastNameFieldController.dispose();
    _dateOfBirthFieldController.dispose();
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    _confirmPasswordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: (){
                onBackButtonPress();
              },
            ),
          ),
          Text("Baymax",style: GoogleFonts.pacifico(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.surfaceTint
          ),),
          const SizedBox(
            height: 12,
          ),
          CustomTextField(label: "First Name", hintText: "Edward" ,controller: _firstNameFieldController,),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(label: "Last Name", hintText: "Newgate" ,controller: _lastNameFieldController,),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(label: "Email", textInputType: TextInputType.emailAddress, hintText: "someone@example.com" ,controller: _emailFieldController,),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(label: "Password", obscureText: true, controller: _passwordFieldController,),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(label: "Confirm Password", obscureText: true, controller: _confirmPasswordFieldController,),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            label: "Date of Birth",
            controller: _dateOfBirthFieldController,
            suffixIcon: IconButton(
              icon: const Icon(Icons.date_range_rounded),
              onPressed: () async{
                DateTime? dateOfBirth=await showDatePicker(
                  context: context,
                  initialDate: DateTime(DateTime.now().year),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
                );
                if(dateOfBirth!=null){
                  _dateOfBirthFieldController.text="${dateOfBirth.year}/${dateOfBirth.month<10?"0${dateOfBirth.month}":dateOfBirth.month}/${dateOfBirth.day<10?"0${dateOfBirth.day}":dateOfBirth.day}";
                }
              },
            ),
            textInputType: TextInputType.datetime,
            hintText: "YYYY/MM/DD",
          ),
          const SizedBox(
            height: 8,
          ),
          MaterialTextButton(
            buttonName: "Sign Up",
            onPressed: () async{
              try{
                if(_passwordFieldController.text!=_confirmPasswordFieldController.text){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password fields not matching")));
                  return;
                }
                if(_passwordFieldController.text.length<8){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password must be at least 8 characters long")));
                  return;
                }
                String dobString=_dateOfBirthFieldController.text.replaceAll("/", "-");
                await performSignUp(_firstNameFieldController.text, _lastNameFieldController.text, _emailFieldController.text, _passwordFieldController.text, dobString);
                if(!mounted){
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User created successfully")));
                onBackButtonPress();
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong. Check your details")));
              }
            },
          ),
        ],
      ),
    );
  }
}
