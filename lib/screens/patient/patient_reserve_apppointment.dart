import 'package:flutter/material.dart';
import 'package:telehealth/widgets_basic/doctor_schedule_card.dart';

class PatientReserveAppointment extends StatelessWidget {
  const PatientReserveAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DoctorScheduleCard(),
      ],
    );
  }
}
