import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telehealth/enums.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  AdminScreen _adminScreen=AdminScreen.payments;
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
            if(_adminScreen==AdminScreen.users){
              return const Text("Manage Users");
            }
            return const Text("Verify Payments");
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
                  title: const Text("Verify Payments"),
                  onTap: (){
                    if(_adminScreen!=AdminScreen.payments){
                      setState(() {
                        _adminScreen=AdminScreen.payments;
                      });
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.supervised_user_circle),
                  title: const Text("Manage Users"),
                  onTap: (){
                    if(_adminScreen!=AdminScreen.users){
                      setState(() {
                        _adminScreen=AdminScreen.users;
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
          if(_adminScreen==AdminScreen.users){
            return Container();
          }
          return Container();
        },
      ),
    );
  }
}
