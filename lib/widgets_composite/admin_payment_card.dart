import 'package:flutter/material.dart';

import '../widgets_basic/filled_material_button.dart';
import 'doctor_medicine_tile.dart';

class AdminPaymentCard extends StatelessWidget {
  const AdminPaymentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Mr.ABC's appointment with Dr.XYZ on 11/22/2022 1:00PM - 2:00PM"),
      subtitle: Text("Reason"),
      // initiallyExpanded: !upcomingAppointment,
      // trailing: Container(),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  DoctorMedicineTile(
                    medicine: "Paracetamol",
                    value: 1,
                    allowModifications: false,
                  ),
                  DoctorMedicineTile(
                    medicine: "Paracetamol",
                    value: 1,
                    allowModifications: false,
                  ),
                ],
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
                child: const Text("Verify Consultation Payment",style: TextStyle(
                  color: Colors.white,
                ),),
              ),
              SizedBox(
                width: 20,
              ),
              FilledMaterialButton(
                onPressed: (){

                },
                child: const Text("Verify Medicine Purchase",style: TextStyle(
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
