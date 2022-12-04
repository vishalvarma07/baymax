import 'package:flutter/material.dart';
import 'package:telehealth/services/api_requests/http_services.dart';
import 'package:telehealth/widgets_basic/custom_text_field.dart';
import 'package:telehealth/widgets_basic/doctor_schedule_card.dart';

class PatientReserveAppointment extends StatefulWidget {
  const PatientReserveAppointment({Key? key}) : super(key: key);

  @override
  State<PatientReserveAppointment> createState() => _PatientReserveAppointmentState();
}

class _PatientReserveAppointmentState extends State<PatientReserveAppointment> {
  final TextEditingController _appointmentReason=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDoctorAppointments(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context,index)=>DoctorScheduleCard(
              doctorName: snapshot.data![index]['fName'],
              doctorSpecification: snapshot.data![index]['specName'],
              rating: double.parse(snapshot.data![index]['rating'].toString()),
              todaySlotID: snapshot.data![index]['today']??[],
              tomorrowSlotID: snapshot.data![index]['nextDay']??[],
              onReserveAppointment: (date,slotID){
                int doctorID=snapshot.data![index]['id'];
                DateTime appointmentDayWithoutTime=DateTime.parse("${date.year}-${date.month<10?"0${date.month}":date.month}-${date.day<10?"0${date.day}":date.day}");
                showDialog(
                  context: context,
                  builder: (context)=>AlertDialog(
                    title: const Text("Book appointment"),
                    content: CustomTextField(label: "Reason/Symptoms",controller: _appointmentReason,),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async{
                          try{
                            await reserveDoctorAppointment(doctorID, slotID, appointmentDayWithoutTime, _appointmentReason.text);
                            if(!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Appointment Reservation successful")));
                            Navigator.pop(context);
                            setState(() {});

                          }catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to reserve appointment")));
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
    );
  }
}
