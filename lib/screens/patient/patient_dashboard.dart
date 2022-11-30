import 'package:flutter/material.dart';
import 'package:telehealth/enums.dart';
import 'package:telehealth/screens/patient/patient_alert_card.dart';
import 'package:telehealth/services/api_requests/http_services.dart';
import 'package:telehealth/widgets_basic/custom_text_button.dart';
import 'package:telehealth/widgets_basic/page_subheading.dart';
import 'package:telehealth/widgets_composite/patient_appointment_card.dart';
import 'package:telehealth/widgets_basic/patient_vitals_card.dart';


class PatientDashboard extends StatelessWidget {
  final Function changeScreen;
  const PatientDashboard({Key? key, required this.changeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPatientDashboard(),
      builder: (BuildContext context,AsyncSnapshot<Map<String,dynamic>> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting || !snapshot.hasData){
          return const Center(child: CircularProgressIndicator(),);
        }
        return ListView(
          children: [
            if(snapshot.data!['data'].isNotEmpty)
              PatientAppointmentCard(
                name: snapshot.data!['patientName'],
                doctorName: snapshot.data!['data'][0]['fName'],
                appointmentDate: DateTime.parse(snapshot.data!['data'][0]['appointmentDate']),
                slot: snapshot.data!['data'][0]['slotId'],
                appointmentID: snapshot.data!['data'][0]['appointmentId'],
                reason: snapshot.data!['data'][0]['reason'],
                onAppointmentCancel: (appointmentID) async {

                },

              ),
            if(snapshot.data!['data'].isEmpty)
              PatientAppointmentCard(
                name: snapshot.data!['patientName'],
                appointmentPresent: false,
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const PageSubheading(subheadingName: "Your vitals"),
                Wrap(
                  children: [
                    PatientVitalsCard(
                      vitalName: "Blood Type",
                      vitalValue: snapshot.data!['bloodType']??"--",
                      valueStringColor: Colors.red,
                    ),
                    PatientVitalsCard(
                      vitalName: "Height",
                      vitalValue: snapshot.data!['height']??"--",
                    ),
                    PatientVitalsCard(
                      vitalName: "Weight",
                      vitalValue: snapshot.data!['weight']??"--",
                    ),
                  ],
                ),
                if(snapshot.data!['yetTopay']>0 || snapshot.data!['yetToverify']>0)...[
                  const PageSubheading(subheadingName: "Alerts"),
                  Wrap(
                    children: [
                      if(snapshot.data!['yetTopay']>0)
                        PatientAlertCard(
                          leading: const Icon(Icons.warning_amber, size: 25,color: Colors.orange,),
                          text: Text("You have ${snapshot.data!['yetTopay']} outstanding payment(s)"),
                          action: CustomTextButton(
                            text: "Go to Payments",
                            onTap: (){
                              changeScreen(PatientScreen.payments);
                            },
                          ),
                        ),
                      if(snapshot.data!['yetToverify']>0)
                        PatientAlertCard(
                          leading: const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2,),
                          ),
                          text: Text("Your ${snapshot.data!['yetToverify']} Payments are waiting for verification"),
                          action: CustomTextButton(
                            text: "Go to Payments",
                            onTap: (){
                              changeScreen(PatientScreen.payments);
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            )
          ],
        );
      }
    );
  }
}
