import 'package:flutter/material.dart';
import 'package:telehealth/services/api_requests/http_services.dart';
import 'package:telehealth/widgets_basic/custom_dropdown.dart';
import 'package:telehealth/widgets_basic/material_text_button.dart';

import '../../widgets_basic/custom_text_field.dart';
import '../../widgets_basic/page_subheading.dart';

class PatientProfile extends StatefulWidget {
  final BuildContext homeScreenContext;
  const PatientProfile({Key? key,required this.homeScreenContext}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState(homeScreenContext);
}

class _PatientProfileState extends State<PatientProfile> {

  final BuildContext homeScreenContext;

  _PatientProfileState(this.homeScreenContext);

  final TextEditingController _firstName=TextEditingController();
  final TextEditingController _lastName=TextEditingController();
  final TextEditingController _phoneNumber=TextEditingController();
  final TextEditingController _apartmentNumber=TextEditingController();
  final TextEditingController _streetName=TextEditingController();
  final TextEditingController _zipcode=TextEditingController();
  final TextEditingController _state=TextEditingController();
  final TextEditingController _dateOfBirth=TextEditingController();
  final TextEditingController _height=TextEditingController();
  final TextEditingController _weight=TextEditingController();
  String bloodType="A+";
  String gender="Male";
  final TextEditingController _password=TextEditingController();
  final TextEditingController _newPassword=TextEditingController();
  final TextEditingController _confirmNewPassword=TextEditingController();

  bool _profileLoaded=false;

  Future<void> loadPatientProfile() async{
    Map<String,dynamic> patientProfile=await getPatientProfile();
    _firstName.text=patientProfile['data'][0]['fName'];
    _lastName.text=patientProfile['data'][0]['lName'];
    _phoneNumber.text=patientProfile['data'][0]['phno'];
    _apartmentNumber.text=patientProfile['data'][0]['apartmentNo'];
    _streetName.text=patientProfile['data'][0]['streetName'];
    _zipcode.text=patientProfile['data'][0]['pincode'].toString();
    _state.text=patientProfile['data'][0]['state'];
    DateTime dobDateTime=DateTime.parse(patientProfile['data'][0]['dob']);
    _dateOfBirth.text="${dobDateTime.year}/${dobDateTime.month<10?"0${dobDateTime.month}":dobDateTime.month}/${dobDateTime.day<10?"0${dobDateTime.day}":dobDateTime.day}";
    _height.text=patientProfile['data'][0]['height'];
    _weight.text=patientProfile['data'][0]['weight'];

    gender=patientProfile['data'][0]['gender'];
    bloodType=patientProfile['data'][0]['bloodType'];

    setState(() {
      _profileLoaded=true;
    });

  }

  @override
  void initState() {
    loadPatientProfile();
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
              CustomTextField(
                label: "Date of Birth",
                controller: _dateOfBirth,
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
                      _dateOfBirth.text="${dateOfBirth.year}/${dateOfBirth.month<10?"0${dateOfBirth.month}":dateOfBirth.month}/${dateOfBirth.day<10?"0${dateOfBirth.day}":dateOfBirth.day}";
                    }
                  },
                ),
                textInputType: TextInputType.datetime,
                hintText: "YYYY/MM/DD",
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
                label: "Street Name/Number",
                hintText: "503",
                takeFullWidth: false,
              ),
              CustomTextField(
                controller: _zipcode,
                label: "Zip Code",
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
          const PageSubheading(subheadingName: "Vitals"),
          Wrap(
            spacing: 24,
            runSpacing: 8,
            children: [
              CustomTextField(
                controller: _height,
                label: "Height",
                hintText: "177 cm",
                textInputType: TextInputType.number,
                takeFullWidth: false,
              ),
              CustomTextField(
                controller: _weight,
                label: "Weight",
                hintText: "75 Kg",
                textInputType: TextInputType.number,
                takeFullWidth: false,
              ),
              CustomDropdown(
                menuOptions: const {
                  "A+":"A+",
                  "A-":"A-",
                  "B+":"B+",
                  "B-":"B-",
                  "AB+":"AB+",
                  "AB-":"AB-",
                  "O+":"O+",
                  "O-":"O-",
                  "H":"H",
                },
                value: bloodType,
                onChanged: (value){
                  bloodType=value;
                },
                takeFullWidth: false,
              ),
            ],
          ),
          MaterialTextButton(
            buttonName: "Save",
            onPressed: () async {
              try{
                DateTime dob=DateTime.parse(_dateOfBirth.text.replaceAll("/", "-"));
                await sendPatientProfile(_firstName.text,_lastName.text,_phoneNumber.text,gender, _height.text, _weight.text, bloodType, _apartmentNumber.text, _streetName.text, _zipcode.text, _state.text, dob.toIso8601String());
                if(!mounted){
                  return;
                }
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
