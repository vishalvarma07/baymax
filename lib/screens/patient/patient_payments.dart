import 'package:flutter/material.dart';
import 'package:telehealth/services/api_requests/http_services.dart';
import 'package:telehealth/widgets_composite/patient_payment_card.dart';

class PatientPayments extends StatefulWidget {
  const PatientPayments({Key? key}) : super(key: key);

  @override
  State<PatientPayments> createState() => _PatientPaymentsState();
}

class _PatientPaymentsState extends State<PatientPayments> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPatientPayments(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // else if(!snapshot.hasData){
        //   return const Center(
        //     child: EmptyScreenPlaceholder(
        //       iconData: FontAwesomeIcons.moneyBill,
        //       text: "No payment history",
        //     ),
        //   );
        // }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index){
            return PatientPaymentCard(
              consultationFee: snapshot.data![index]['consultationFee'],
              appointmentDate: DateTime.parse(snapshot.data![index]['appointmentDate']),
              slotID: snapshot.data![index]['slotId'],
              doctorName: snapshot.data![index]['dName'],
              meds: snapshot.data![index]['meds'],
              paid: snapshot.data![index]['payStatus'],
              verified: snapshot.data![index]['verifiedBy'],
              onFeePayment: () async{
                try{
                  int paymentID=snapshot.data![index]['id'];
                  await completePatientPayment(paymentID);
                  if(!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment Complete")));
                  setState(() {});
                }catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to make payment")));
                }
              },
            );
          },
        );
      },
    );
  }
}

