import 'package:flutter/material.dart';
import 'package:telehealth/const.dart';
import 'package:telehealth/widgets_basic/material_text_button.dart';

class PatientPaymentCard extends StatelessWidget {
  final String doctorName;
  final int slotID;
  final DateTime appointmentDate;
  final int consultationFee;
  final dynamic meds;
  final Function onFeePayment;
  final bool verified;
  final bool paid;
  const PatientPaymentCard({Key? key,required this.onFeePayment, required this.doctorName, required this.slotID, required this.appointmentDate, required this.consultationFee, this.meds, required this.paid, required this.verified}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalMedicineCost=0;
    int totalCost=consultationFee;
    for(int i=0;i<meds.length;i++){
      totalMedicineCost+=int.parse((meds[i]['quantity']*meds[i]['price']).toString());
    }
    totalCost+=totalMedicineCost;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dr.$doctorName on ${appointmentDate.month}/${appointmentDate.day}/${appointmentDate.year}",style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: backgroundColor,
                  ),),
                  Text("$slotID:00 to ${slotID+1}:00"),
                  Text("\$$consultationFee", style: const TextStyle(
                    color: backgroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),),
                ],
              ),
            ),
            const SizedBox(
              height: 150,
              child: VerticalDivider(
                endIndent: 8,
                indent: 8,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Pharmacy Purchase",style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: backgroundColor,
                  ),),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: meds.length,
                      itemBuilder: (context,index)=>Text("${meds[index]['quantity']} ${meds[index]['name']}: \$${meds[index]['price']*meds[index]['quantity']}"),
                    ),
                  ),
                  Text("\$$totalMedicineCost", style: const TextStyle(
                    color: backgroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),),
                ],
              ),
            ),
            MaterialTextButton(
              buttonName: paid?verified?"Payment and verification successful":"Payment complete! Awaiting verification":"Complete Payment",
              onPressed: !paid?(){
                showDialog(
                  context: context,
                  builder: (context)=>AlertDialog(
                    title: const Text("Complete Payment"),
                    content: Text("Pay \$$totalCost and complete transaction?"),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          onFeePayment();
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              }:null,
            ),
          ],
        ),
      ),
    );
  }
}
