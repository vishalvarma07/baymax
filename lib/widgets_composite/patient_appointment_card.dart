import 'package:flutter/material.dart';
import 'package:telehealth/widgets_basic/welcome_card.dart';

import '../widgets_basic/material_text_button.dart';


class PatientAppointmentCard extends StatelessWidget {
  const PatientAppointmentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WelcomeCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text("Welcome Sashank!",style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Colors.white
            ),),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Text("You have an appointment with Dr. XYZ on 12/12/22 from 4:00PM to 7:00PM",style: TextStyle(
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
          MaterialTextButton(
            buttonName: "Manage Reservation",
            onPressed: (){
              showDialog(
                context: context,
                builder: (context)=>AlertDialog(
                  title: const Text("Appointment Info"),
                  content: Text("Symptom: Stomach Ache"),
                  actions: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
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
