import 'package:flutter/material.dart';
import 'package:telehealth/screens/patient/upcoming_appointments.dart';

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
        title: const Text("Home"),
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

                  },
                ),
                ListTile(
                  leading: const Icon(Icons.timelapse),
                  title: const Text("Upcoming Appointments"),
                  onTap: (){

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
            return Column();
          }
          return const UpcomingAppointments();
        },
      ),
    );
  }
}
