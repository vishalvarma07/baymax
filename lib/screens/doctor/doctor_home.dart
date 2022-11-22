import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telehealth/enums.dart';
import 'package:telehealth/screens/doctor/doctor_dashboard.dart';
import 'package:telehealth/screens/doctor/doctor_profile.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({Key? key}) : super(key: key);

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {

  DoctorScreen _doctorScreen=DoctorScreen.home;
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
            if(_doctorScreen==DoctorScreen.profile){
              return const Text("Profile");
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
                    if(_doctorScreen!=DoctorScreen.home){
                      setState(() {
                        _doctorScreen=DoctorScreen.home;
                      });
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.supervised_user_circle),
                  title: const Text("Profile"),
                  onTap: (){
                    if(_doctorScreen!=DoctorScreen.profile){
                      setState(() {
                        _doctorScreen=DoctorScreen.profile;
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
          if(_doctorScreen==DoctorScreen.profile){
            return DoctorProfile(homeScreenContext: _screenContext,);
          }
          return DoctorDashboard();
        },
      ),
    );
  }
}
