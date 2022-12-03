import 'package:flutter/material.dart';
import 'package:telehealth/widgets_basic/filled_material_button.dart';
import 'package:telehealth/widgets_composite/doctor_medicine_tile.dart';

class DoctorAppointmentCard extends StatefulWidget {
  final String appointmentText;
  final String reason;
  final bool upcomingAppointment;
  final VoidCallback? onAppointmentCancel;
  final dynamic meds;
  const DoctorAppointmentCard({Key? key, required this.appointmentText, required this.reason, this.upcomingAppointment=true, this.onAppointmentCancel,this.meds}) : super(key: key);

  @override
  State<DoctorAppointmentCard> createState() => _DoctorAppointmentCardState(appointmentText, reason, upcomingAppointment, onAppointmentCancel, meds);
}

class _DoctorAppointmentCardState extends State<DoctorAppointmentCard> {

  final String appointmentText;
  final String reason;
  final bool upcomingAppointment;
  final VoidCallback? onAppointmentCancel;
  final dynamic meds;

  _DoctorAppointmentCardState(this.appointmentText, this.reason, this.upcomingAppointment, this.onAppointmentCancel, this.meds);


  void initializeMedCounters(){
    if(!upcomingAppointment){
      for(int i=0;i<meds.length;i++){
        meds['count']=0;
      }
    }
  }

  @override
  void initState() {
    initializeMedCounters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(appointmentText),
      subtitle: Text(reason),
      initiallyExpanded: !upcomingAppointment,
      expandedCrossAxisAlignment: CrossAxisAlignment.center,
      trailing: upcomingAppointment?Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onAppointmentCancel,
            tooltip: "Cancel Appointment",
            icon: const Icon(Icons.cancel,color: Colors.red,),
          ),
          // IconButton(
          //   onPressed: (){
          //
          //   },
          //   icon: const Icon(Icons.check_circle,color: Colors.green,),
          // ),
        ],
      ):null,
      children: upcomingAppointment?[]:[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 250,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxWidth: 500
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: meds.length,
                  itemBuilder: (context,index)=>DoctorMedicineTile(
                    medicine: meds[index]['mName'],
                    value: meds[index]['count'],
                    plusOnPress: (){
                      if(meds[index]['count']+1<=meds[index]['mQuantity']){
                        setState(() {
                          meds[index]['count']++;
                        });
                      }
                    },
                    minusOnPress: (){
                      if(meds[index]['count']-1>=0){
                        setState(() {
                          meds[index]['count']--;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledMaterialButton(
                onPressed: (){

                },
                child: const Text("End Appointment",style: TextStyle(
                  color: Colors.white,
                ),),
              ),
            ],
          ),
        )
      ],
    );
  }
}

