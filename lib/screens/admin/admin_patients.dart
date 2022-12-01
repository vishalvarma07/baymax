import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telehealth/const.dart';
import 'package:telehealth/services/api_requests/http_services.dart';

class AdminPatients extends StatefulWidget {
  const AdminPatients({Key? key}) : super(key: key);

  @override
  State<AdminPatients> createState() => _AdminPatientsState();
}

class _AdminPatientsState extends State<AdminPatients> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllPatientDetails(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        if(snapshot.hasError){
          return const Center(
            child: Text("An error has occurred",style: TextStyle(
              color: backgroundColor,
              fontSize: 20,
            ),),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context,index)=>ListTile(
            leading: Text("${index+1}"),
            title: Text("${snapshot.data![index]['lName']} ${snapshot.data![index]['fName']}"),
            subtitle: Text("Account Status: ${snapshot.data![index]['ban']==1?"Banned":"Active"}"),
            trailing: IconButton(
              icon: Icon(snapshot.data![index]['ban']==1?FontAwesomeIcons.check:FontAwesomeIcons.ban, color: snapshot.data![index]['ban']==1?Colors.green:Colors.red,),
              onPressed: (){
                bool userBanned=snapshot.data![index]['ban']==1;
                showDialog(
                  context: context,
                  builder: (context)=>AlertDialog(
                    title: Text("${userBanned?"Un":""}Ban user?"),
                    content: Text("User will be ${userBanned?"un":""}banned"),
                    actions: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text("OK"),
                        onPressed: (){
                          //TODO Ban/Unban user here
                          Navigator.pop(context);
                        },
                      ),

                    ],
                  ),
                );

              },
            ),
          ),
        );
      }
    );
  }
}
