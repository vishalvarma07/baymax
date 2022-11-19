import 'package:flutter/material.dart';
import 'package:telehealth/widgets_basic/doctor_appointment_card.dart';
import 'package:telehealth/widgets_basic/page_subheading.dart';
import 'package:telehealth/widgets_composite/doctor_rating_card.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({Key? key}) : super(key: key);

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DoctorRatingCard(),
        SizedBox(
          height: 8,
        ),
        const PageSubheading(subheadingName: "Ongoing Appointment"),
        DoctorAppointmentCard(
          appointmentText: "Mr. ABC on 11/23/2022 1:00PM-2:00PM",
          reason: "Stomach Ache",
          upcomingAppointment: false,
          onRemarkSave: (){

          },
        ),
        const SizedBox(
          height: 8,
        ),
        const PageSubheading(subheadingName: "Upcoming Appointments"),
        DoctorAppointmentCard(
          appointmentText: "Mr. ABC on 11/23/2022 1:00PM-2:00PM",
          reason: "Stomach Ache",
          onAppointmentCancel: (){},
        ),
      ],
    );
  }
}
