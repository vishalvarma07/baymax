import 'package:flutter/material.dart';
import 'package:telehealth/services/api_requests/http_services.dart';
import 'package:telehealth/widgets_composite/admin_payment_card.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAdminPatientPayments(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        // print(snapshot.data!['data']);
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context,index)=>AdminPaymentCard(
            doctorName: snapshot.data![index]['dname'],
            patientName: snapshot.data![index]['pname'],
            appointmentDate: DateTime.parse(snapshot.data![index]['appointmentDate']),
            consultationFee: snapshot.data![index]['consultationFee'],
            feePaid: snapshot.data![index]['payStatus'],
            feeVerified: snapshot.data![index]['adminverified'],
            slotId: snapshot.data![index]['slotId'],
            meds: snapshot.data![index]['meds'],
            paymentID: snapshot.data![index]['id'],
            onVerifyComplete: setState,
          ),
        );
      },
    );
  }
}
