import 'package:flutter/material.dart';

import '../../services/api_requests/http_services.dart';
import '../../services/shared_prefs.dart';
import '../../widgets_basic/custom_dropdown.dart';
import '../../widgets_basic/custom_text_field.dart';
import '../../widgets_basic/material_text_button.dart';
import '../../widgets_basic/page_subheading.dart';

class DoctorProfile extends StatefulWidget {
  final BuildContext homeScreenContext;
  const DoctorProfile({Key? key, required this.homeScreenContext}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState(homeScreenContext);
}

class _DoctorProfileState extends State<DoctorProfile> {

  final BuildContext homeScreenContext;

  _DoctorProfileState(this.homeScreenContext);

  final TextEditingController _firstName=TextEditingController();
  final TextEditingController _lastName=TextEditingController();
  final TextEditingController _phoneNumber=TextEditingController();
  String gender="male";
  final TextEditingController _password=TextEditingController();
  final TextEditingController _newPassword=TextEditingController();
  final TextEditingController _confirmNewPassword=TextEditingController();

  bool _profileLoaded=false;
  
  
  void loadDoctorProfile() async{
    Map<String,dynamic> doctorProfile=await getDoctorProfile();
    _firstName.text=doctorProfile['fName'];
    _lastName.text=doctorProfile['lName'];
    _phoneNumber.text=doctorProfile['phno']??"";
    // DateTime dobDateTime=DateTime.parse(doctorProfile['dob']);
    // _dateOfBirth.text="${dobDateTime.year}/${dobDateTime.month<10?"0${dobDateTime.month}":dobDateTime.month}/${dobDateTime.day<10?"0${dobDateTime.day}":dobDateTime.day}";
    gender=doctorProfile['gender']??"Male";

    setState(() {
      _profileLoaded=true;
    });
  }


  @override
  void initState() {
    loadDoctorProfile();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    if(!_profileLoaded){
      return const Center(child: CircularProgressIndicator(),);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageSubheading(subheadingName: "Personal"),
          Wrap(
            spacing: 24,
            runSpacing: 8,
            children: [
              CustomTextField(
                controller: _firstName,
                label: "First Name",
                hintText: "Jim",
                takeFullWidth: false,
              ),
              CustomTextField(
                  controller: _lastName,
                  label: "Last Name",
                  hintText: "Jim",
                  takeFullWidth: false
              ),
              CustomTextField(
                controller: _phoneNumber,
                label: "Phone Number",
                hintText: "+10000000000",
                textInputType: TextInputType.phone,
                takeFullWidth: false,
              ),
              CustomDropdown(
                menuOptions: const {
                  "Male":"Male",
                  "Female":"Female",
                  "Other":"Other"
                },
                value: gender,
                onChanged: (value){
                  setState(() {
                    gender=value;
                  });
                },
                takeFullWidth: false,
              ),
              SizedBox(
                height: 50,
                child: MaterialTextButton(
                  buttonName: "Change Password",
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context)=>AlertDialog(
                        title: const Text("Change Password"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              controller: _password,
                              label: "Old Password",
                              hintText: "Password",
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              controller: _newPassword,
                              label: "New Password",
                              hintText: "Password",
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              controller: _confirmNewPassword,
                              label: "Confirm New Password",
                              hintText: "Password",
                              obscureText: true,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async{
                              if(_confirmNewPassword.text!=_newPassword.text){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("New password and Confirm New password fields should match")));
                                return;
                              }
                              if(_newPassword.text.length<8){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("New password must be at least 8 characters long")));
                                return;
                              }
                              //Change password and result
                              try{
                                await changePassword(_password.text, _newPassword.text);
                                if(!mounted){
                                  return;
                                }
                                clearStoredLoginData();
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password Changed Successfully")));
                                Navigator.pop(context);
                                Navigator.pop(homeScreenContext);
                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An unknown error occurred! Check your old password")));
                              }
                            },
                            child: const Text("Confirm"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 8,
          ),
          MaterialTextButton(
            buttonName: "Save",
            onPressed: () async{
              try{
                await sendDoctorProfile(_firstName.text,_lastName.text,_phoneNumber.text, gender,);
                if(!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated Successfully")));
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong! Check input values")));
              }
            },
          ),

        ],
      ),
    );
  }
}
