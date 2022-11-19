import 'package:flutter/material.dart';
import 'package:telehealth/enums.dart';
import 'package:telehealth/screens/patient/patient_alert_card.dart';
import 'package:telehealth/widgets_basic/custom_text_button.dart';
import 'package:telehealth/widgets_basic/page_subheading.dart';
import 'package:telehealth/widgets_composite/patient_appointment_card.dart';
import 'package:telehealth/widgets_basic/welcome_card.dart';
import 'package:telehealth/widgets_basic/patient_vitals_card.dart';


class PatientDashboard extends StatelessWidget {
  final Function changeScreen;
  const PatientDashboard({Key? key, required this.changeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PatientAppointmentCard(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const PageSubheading(subheadingName: "Your vitals"),
            Wrap(
              children: [
                PatientVitalsCard(
                  vitalName: "Blood Type",
                  vitalValue: "A+",
                  valueStringColor: Colors.red,
                ),
                PatientVitalsCard(
                  vitalName: "Blood Pressure",
                  vitalValue: "162",
                ),
                PatientVitalsCard(
                  vitalName: "Height",
                  vitalValue: "--",
                ),
                PatientVitalsCard(
                  vitalName: "Weight",
                  vitalValue: "63",
                ),
                PatientVitalsCard(
                  vitalName: "Pulse",
                  vitalValue: "72",
                ),
              ],
            ),
            const PageSubheading(subheadingName: "Alerts"),
            Wrap(
              children: [
                PatientAlertCard(
                  leading: const Icon(Icons.warning_amber, size: 25,color: Colors.orange,),
                  text: Text("You have 4 outstanding payments"),
                  action: CustomTextButton(
                    text: "Go to Payments",
                    onTap: (){
                      changeScreen(PatientScreen.payments);
                    },
                  ),
                ),
                PatientAlertCard(
                  leading: const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2,),
                  ),
                  text: const Text("Your 3 Payments are waiting for verification"),
                  action: CustomTextButton(
                    text: "Go to Payments",
                    onTap: (){
                      changeScreen(PatientScreen.payments);
                    },
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
