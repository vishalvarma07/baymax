import 'package:flutter/material.dart';

import '../../services/api_requests/http_services.dart';
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
  final TextEditingController _apartmentNumber=TextEditingController();
  final TextEditingController _streetName=TextEditingController();
  final TextEditingController _zipcode=TextEditingController();
  final TextEditingController _state=TextEditingController();
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
    _apartmentNumber.text=doctorProfile['apartmentNo']??"";
    _streetName.text=doctorProfile['streetName']??"";
    _zipcode.text=doctorProfile['pincode']!=null?doctorProfile['pincode'].toString():"".toString();
    _state.text=doctorProfile['state']??"";
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
                            onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(homeScreenContext);
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
          const PageSubheading(subheadingName: "Address"),
          Wrap(
            spacing: 24,
            runSpacing: 8,
            children: [
              CustomTextField(
                controller: _apartmentNumber,
                label: "Apartment Number",
                hintText: "137",
                takeFullWidth: false,
              ),
              CustomTextField(
                controller: _streetName,
                label: "Street Number",
                hintText: "503",
                takeFullWidth: false,
              ),
              CustomTextField(
                controller: _zipcode,
                label: "Zipcode",
                hintText: "75080",
                takeFullWidth: false,
              ),
              CustomTextField(
                controller: _state,
                label: "State",
                hintText: "Texas",
                takeFullWidth: false,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          MaterialTextButton(
            buttonName: "Save",
            onPressed: () async{
              try{
                await sendDoctorProfile(_firstName.text,_lastName.text,_phoneNumber.text, gender, _apartmentNumber.text, _streetName.text, _zipcode.text, _state.text);
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
