import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telehealth/screens/patient/patient_dashboard.dart';
import 'package:telehealth/screens/patient/patient_payments.dart';
import 'package:telehealth/screens/patient/patient_reserve_apppointment.dart';

import '../../enums.dart';

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
            }
            return const Text("Dashboard");
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Column(
              children: [
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
                // const Spacer(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap:(){
                    Navigator.pop(context);
                    Navigator.pop(_screenContext);
                  }
                )
              ],
            )
          ],
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
          }
          return const PatientPayments();
        },
      ),
    );
  }
}
