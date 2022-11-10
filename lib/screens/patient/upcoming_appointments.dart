import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if(!snapshot.hasData){
          return Center(
            child: Column(
              children: const [
                Icon(FontAwesomeIcons.temperatureEmpty,color: Colors.grey,),
                Text("No Scheduled Appointments",style: TextStyle(
                  color: Colors.grey
                ),),
              ],
            ),
          );
        }
        return Column();
      },
    );
  }
}
