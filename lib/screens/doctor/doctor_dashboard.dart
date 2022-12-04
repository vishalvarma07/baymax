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
                Builder(
                  builder: (context){
                    DateTime appointmentDate=DateTime.parse(snapshot.data!['ongoing'][i]['appointmentDate']);
                    return DoctorAppointmentCard(
                      appointmentText: "Appointment with ${snapshot.data!['ongoing'][i]['patientName']} on ${appointmentDate.month}/${appointmentDate.day}/${appointmentDate.year} ${snapshot.data!['ongoing'][i]['slotId']}:00-${snapshot.data!['ongoing'][i]['slotId']+1}:00",
                      reason: snapshot.data!['ongoing'][i]['reason'],
                      meds: snapshot.data!['meds'],
                      endAppointment: (meds) async{
                        try{
                          await doctorEndAppointment(meds);
                          if(!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Appointment ended successfully")));
                          setState(() {});
                        }catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to end appointment")));
                        }
                      },
                      upcomingAppointment: false,
                    );
                  },
                )
            ],

            const SizedBox(
              height: 8,
            ),
            if(snapshot.data!['upcoming'].isNotEmpty)...[
              const PageSubheading(subheadingName: "Upcoming Appointments"),
              for(int i=0;i<snapshot.data!['upcoming'].length;i++)
                Builder(
                  builder: (context){
                    DateTime appointmentDate=DateTime.parse(snapshot.data!['upcoming'][i]['appointmentDate']);
                    return DoctorAppointmentCard(
                      appointmentText: "Appointment with ${snapshot.data!['upcoming'][i]['patientName']} on ${appointmentDate.month}/${appointmentDate.day}/${appointmentDate.year} ${snapshot.data!['upcoming'][i]['slotId']}:00-${snapshot.data!['upcoming'][i]['slotId']+1}:00",
                      reason: snapshot.data!['upcoming'][i]['reason'],
                      onAppointmentCancel: () async{
                        try{
                          await cancelAppointment(snapshot.data!['upcoming'][i]['appointmentId']);
                          if(!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Appointment Cancelled Successfully")));
                          setState(() {});
                        }catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to cancel appointment")));
                        }
                      },
                    );
                  }
                ),
            ]
          ],
        );
      }
    );
  }
}
