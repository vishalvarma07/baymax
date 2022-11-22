import 'package:flutter/material.dart';
import 'package:telehealth/widgets_basic/custom_text_field.dart';
import 'package:telehealth/widgets_basic/filled_material_button.dart';
import 'package:telehealth/widgets_composite/doctor_medicine_tile.dart';

class DoctorAppointmentCard extends StatelessWidget {
  final String appointmentText;
  final String reason;
  final bool upcomingAppointment;
  final VoidCallback? onAppointmentCancel;
  final VoidCallback? onRemarkSave;
  const DoctorAppointmentCard({Key? key, required this.appointmentText, required this.reason, this.upcomingAppointment=true, this.onAppointmentCancel, this.onRemarkSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(appointmentText),
      subtitle: Text(reason),
      initiallyExpanded: !upcomingAppointment,
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
            height: 200,
            child: Row(
              children: [
                const Expanded(
                  child: CustomTextField(
                    label: "Remarks",
                    takeFullHeight: true,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        DoctorMedicineTile(
                          medicine: "Paracetamol",
                          value: 1,
                          plusOnPress: (){

                          },
                          minusOnPress: (){

                          },
                        ),
                        DoctorMedicineTile(
                          medicine: "Paracetamol",
                          value: 1,
                          plusOnPress: (){

                          },
                          minusOnPress: (){

                          },
                        ),
                        DoctorMedicineTile(
                          medicine: "Paracetamol",
                          value: 1,
                          plusOnPress: (){

                          },
                          minusOnPress: (){

                          },
                        ),
                        DoctorMedicineTile(
                          medicine: "Paracetamol",
                          value: 1,
                          plusOnPress: (){

                          },
                          minusOnPress: (){

                          },
                        ),
                        DoctorMedicineTile(
                          medicine: "Paracetamol",
                          value: 1,
                          plusOnPress: (){

                          },
                          minusOnPress: (){

                          },
                        ),
                        DoctorMedicineTile(
                          medicine: "Paracetamol",
                          value: 1,
                          plusOnPress: (){

                          },
                          minusOnPress: (){

                          },
                        ),
                        DoctorMedicineTile(
                          medicine: "Paracetamol",
                          value: 1,
                          plusOnPress: (){

                          },
                          minusOnPress: (){

                          },
                        ),
                        DoctorMedicineTile(
                          medicine: "Paracetamol",
                          value: 1,
                          plusOnPress: (){

                          },
                          minusOnPress: (){

                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledMaterialButton(
                onPressed: onRemarkSave,
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
