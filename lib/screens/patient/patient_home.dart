import 'package:flutter/material.dart';
import 'package:telehealth/screens/patient/patient_dashboard.dart';
import 'package:telehealth/screens/patient/patient_payments.dart';

import '../../enums.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({Key? key}) : super(key: key);

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {

  PatientScreen _patientScreen=PatientScreen.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context){
            if(_patientScreen==PatientScreen.payments){
              return const Text("Payments");
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
          }
          return const PatientPayments();
        },
      ),
    );
  }
}
