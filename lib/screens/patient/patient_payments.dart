import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telehealth/widgets_basic/empty_screen_placeholder.dart';
import 'package:telehealth/widgets_basic/page_subheading.dart';
import 'package:telehealth/widgets_composite/patient_payment_card.dart';

class PatientPayments extends StatelessWidget {
  const PatientPayments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
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
          itemCount: 10,
          itemBuilder: (BuildContext context, int index){
            return PatientPaymentCard(
              onConsultationFeePayment: (){
                showDialog(
                  context: context,
                  builder: (context)=>AlertDialog(
                    title: Text("Confirm?"),
                    content: Text("Do you want to confirm your payment of \$500?"),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              onMedicineFeePayment: index%3==0?null:(){
                showDialog(
                  context: context,
                  builder: (context)=>AlertDialog(
                    title: Text("Confirm?"),
                    content: Text("Do you want to confirm your medicine purchase worth \$500?"),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
