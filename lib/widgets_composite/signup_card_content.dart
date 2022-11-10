import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final TextEditingController dateOfBirthFieldController=TextEditingController();

  _SignupCardContentState(this.onBackButtonPress);

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
          CustomTextField(label: "Email", textInputType: TextInputType.emailAddress, hintText: "someone@example.com" ,onChanged: (value){},),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(label: "Password", obscureText: true, onChanged: (value){},),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(label: "Confirm Password", obscureText: true, onChanged: (value){},),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            label: "Date of Birth",
            controller: dateOfBirthFieldController,
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
                  dateOfBirthFieldController.text="${dateOfBirth.month}/${dateOfBirth.day}/${dateOfBirth.year}";
                }
              },
            ),
            textInputType: TextInputType.datetime,
            hintText: "MM/DD/YYYY",
          ),
          const SizedBox(
            height: 8,
          ),
          MaterialTextButton(
            buttonName: "Sign Up",
            onPressed: (){

            },
          ),
        ],
      ),
    );
  }
}
