import 'package:flutter/material.dart';
import 'package:telehealth/services/api_requests/http_services.dart';
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
    return FutureBuilder(
      future: getDoctorDashboardContent(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }

        return ListView(
          children: [
            DoctorRatingCard(
              doctorName: snapshot.data!['dName'],
              rating: double.parse(snapshot.data!['rating'].toString()),
            ),
            const SizedBox(
              height: 8,
            ),
            if(snapshot.data!['ongoing'].isNotEmpty)...[
              const PageSubheading(subheadingName: "Ongoing Appointment(s)"),
              for(int i=0;i<snapshot.data!['ongoing'].length;i++)
                DoctorAppointmentCard(
                  appointmentText: "Mr. ABC on 11/23/2022 1:00PM-2:00PM",
                  reason: "Stomach Ache",
                  upcomingAppointment: false,
                ),
            ],

            const SizedBox(
              height: 8,
            ),
            if(snapshot.data!['upcoming'].isNotEmpty)...[
              const PageSubheading(subheadingName: "Upcoming Appointments"),
              DoctorAppointmentCard(
                appointmentText: "Mr. ABC on 11/23/2022 1:00PM-2:00PM",
                reason: "Stomach Ache",
                onAppointmentCancel: (){},
              ),
            ]
          ],
        );
      }
    );
  }
}
