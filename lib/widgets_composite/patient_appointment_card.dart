import 'package:flutter/material.dart';
import 'package:telehealth/widgets_basic/welcome_card.dart';

import '../widgets_basic/material_text_button.dart';


class PatientAppointmentCard extends StatelessWidget {
  final String? name, doctorName;
  final DateTime? appointmentDate;
  final int? slot;
  final int? appointmentID;
  final String? reason;
  final bool appointmentPresent;
  final Function? onAppointmentCancel;
  const PatientAppointmentCard({Key? key, this.name, this.doctorName, this.appointmentDate, this.slot, this.appointmentID, this.reason, this.onAppointmentCancel, this.appointmentPresent=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WelcomeCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text("Welcome $name!",style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Colors.white
            ),),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Text(appointmentPresent?"You have an appointment with Dr. $doctorName on ${appointmentDate!.month}/${appointmentDate!.day}/${appointmentDate!.year} from $slot:00 to ${slot!+1}:00":"You don't have any scheduled upcoming appointments!",style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.white
                ),),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if(appointmentPresent)
            MaterialTextButton(
              buttonName: "Manage Reservation",
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context)=>AlertDialog(
                    title: const Text("Appointment Info"),
                    content: Text("Reason: $reason"),
                    actions: [
                      TextButton(
                        onPressed: () async{
                          Navigator.pop(context);
                          onAppointmentCancel!(appointmentID);
                        },
                        child: const Text("Cancel Appointment"),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
