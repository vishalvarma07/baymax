import 'package:flutter/material.dart';
import 'package:telehealth/const.dart';
import 'package:telehealth/services/api_requests/http_services.dart';

import '../widgets_basic/filled_material_button.dart';
import 'doctor_medicine_tile.dart';

class AdminPaymentCard extends StatelessWidget {
  final String doctorName;
  final String patientName;
  final DateTime appointmentDate;
  final int consultationFee;
  final bool feePaid;
  final bool feeVerified;
  final int slotId;
  final int paymentID;
  final dynamic meds;
  final Function onVerifyComplete;
  const AdminPaymentCard({Key? key, required this.doctorName, required this.patientName, required this.appointmentDate, required this.consultationFee, required this.feePaid, required this.feeVerified, required this.paymentID, required this.meds, required this.slotId, required this.onVerifyComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalMedicineAmount=0;
    for(int i=0;i<meds.length;i++){
      totalMedicineAmount+=int.parse((meds[i]['quantity']*meds[i]['price']).toString());
    }
    return ExpansionTile(
      title: Text("Mr.$patientName's appointment with Dr.$doctorName on ${appointmentDate.month}/${appointmentDate.day}/${appointmentDate.year} $slotId:00 - ${slotId+1}:00"),
      // initiallyExpanded: !upcomingAppointment,
      trailing: (feePaid)?Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(feePaid)
            Icon(Icons.check,color: feeVerified?Colors.green:Colors.amber,),
          // Icon(Icons.check,color: Colors.green,),
        ],
      ):null,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            constraints: const BoxConstraints(
              maxWidth: 500
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: meds.length,
                itemBuilder: (context,index)=>DoctorMedicineTile(
                  medicine: "${meds[index]['name']} Qty ${meds[index]['quantity']}",
                  value: int.parse((meds[index]['quantity']*meds[index]['price']).toString()),
                  allowModifications: false,
                ),
              ),
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Column(
            children: [
              DoctorMedicineTile(
                medicine: "Doctor Consultation Fee",
                value: consultationFee,
                allowModifications: false,
              ),
              DoctorMedicineTile(
                medicine: "Medicine Sum total",
                value: totalMedicineAmount,
                allowModifications: false,
              ),
              DoctorMedicineTile(
                medicine: "Total",
                value: consultationFee+totalMedicineAmount,
                allowModifications: false,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledMaterialButton(
                onPressed: !feePaid?null:!feeVerified?() async{
                  try{
                    await verifyPatientPayment(paymentID);
                    onVerifyComplete((){});
                  }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment verification failed")));
                  }
                }:null,
                child: Text(!feePaid?"Fee not paid by patient":(feeVerified)?"Verified":"Verify Payment",style: TextStyle(
                  color: !feePaid?backgroundColor.withOpacity(0.5):(feeVerified)?backgroundColor.withOpacity(0.5):Colors.white,
                ),),
              ),
              // const SizedBox(
              //   width: 20,
              // ),
              // FilledMaterialButton(
              //   onPressed: (){
              //
              //   },
              //   child: const Text("Verify Medicine Purchase",style: TextStyle(
              //     color: Colors.white,
              //   ),),
              // ),
            ],
          ),
        )
      ],
    );
  }
}
