import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telehealth/screens/patient/patient_dashboard.dart';
import 'package:telehealth/screens/patient/patient_payments.dart';
import 'package:telehealth/screens/patient/patient_profile.dart';
import 'package:telehealth/screens/patient/patient_reserve_apppointment.dart';

import '../../const.dart';
import '../../enums.dart';
import '../../services/shared_prefs.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({Key? key}) : super(key: key);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {

  PatientScreen _patientScreen=PatientScreen.home;

  late BuildContext _screenContext;

  @override
  void initState() {
    _screenContext=context;
    super.initState();
    checkAppointmentComplete();
  }

  void checkAppointmentComplete(){
    Timer(Duration(seconds: 1),(){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=>AlertDialog(
          title: Text("Rate your appointment with Dr.XYZ"),
          content: RatingBar(
            ratingWidget: RatingWidget(
              empty: const Icon(Icons.star_border_outlined,color: backgroundColor,),
              half: const Icon(Icons.star_half,color: backgroundColor,),
              full: const Icon(Icons.star,color: backgroundColor,),
            ),
            onRatingUpdate: (value){

            },
          ),
          actions: [
            TextButton(
              child: const Text("Submit"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context){
            if(_patientScreen==PatientScreen.payments){
              return const Text("Payments");
            }else if(_patientScreen==PatientScreen.reserveAppointment){
              return const Text("Reserve Appointment");
            }else if(_patientScreen==PatientScreen.profile){
              return const Text("Profile");
            }
            return const Text("Dashboard");
          },
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  Text("Baymax",style: GoogleFonts.pacifico(
                      fontSize: 52,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surfaceTint
                  ),),
                  const SizedBox(
                    height: 25,
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Home"),
                    onTap: (){
                      if(_patientScreen!=PatientScreen.home){
                        setState(() {
                          _patientScreen=PatientScreen.home;
                        });
                      }
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.businessTime),
                    title: const Text("Reserve Appointment"),
                    onTap: (){
                      if(_patientScreen!=PatientScreen.reserveAppointment){
                        setState(() {
                          _patientScreen=PatientScreen.reserveAppointment;
                        });
                      }
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.money),
                    title: const Text("Payments"),
                    onTap: (){
                      if(_patientScreen!=PatientScreen.payments){
                        setState(() {
                          _patientScreen=PatientScreen.payments;
                        });
                      }
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.supervised_user_circle),
                    title: const Text("Profile"),
                    onTap: (){
                      if(_patientScreen!=PatientScreen.profile){
                        setState(() {
                          _patientScreen=PatientScreen.profile;
                        });
                      }
                      Navigator.pop(context);
                    },
                  ),
                  // const Spacer(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                    onTap:(){
                      clearStoredLoginData();
                      Navigator.pop(context);
                      Navigator.pop(_screenContext);
                    }
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (context){
          if(_patientScreen==PatientScreen.home){
            return PatientDashboard(
              changeScreen: (value){
                setState(() {
                  _patientScreen=value;
                });
              },
            );
          }else if(_patientScreen==PatientScreen.reserveAppointment){
            return PatientReserveAppointment();
          }else if(_patientScreen==PatientScreen.profile){
            return PatientProfile(homeScreenContext: _screenContext,);
          }
          return const PatientPayments();
        },
      ),
    );
  }
}
