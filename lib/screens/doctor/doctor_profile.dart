import 'package:flutter/material.dart';

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
  final TextEditingController _streetNumber=TextEditingController();
  final TextEditingController _city=TextEditingController();
  final TextEditingController _state=TextEditingController();
  final TextEditingController _dateOfBirth=TextEditingController();
  final TextEditingController _country=TextEditingController();
  String gender="male";
  final TextEditingController _password=TextEditingController();
  final TextEditingController _newPassword=TextEditingController();
  final TextEditingController _confirmNewPassword=TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  "Male":"male",
                  "Female":"female",
                  "Other":"other"
                },
                value: gender,
                onChanged: (){

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
                controller: _streetNumber,
                label: "Street Number",
                hintText: "503",
                takeFullWidth: false,
              ),
              CustomTextField(
                controller: _city,
                label: "City",
                hintText: "Dallas",
                takeFullWidth: false,
              ),
              CustomTextField(
                controller: _state,
                label: "State",
                hintText: "Texas",
                takeFullWidth: false,
              ),
              CustomTextField(
                controller: _country,
                label: "Country",
                hintText: "United States",
                takeFullWidth: false,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          MaterialTextButton(
            buttonName: "Save",
            onPressed: (){

            },
          ),

        ],
      ),
    );
  }
}
