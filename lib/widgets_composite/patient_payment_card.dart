import 'package:flutter/material.dart';
import 'package:telehealth/const.dart';
import 'package:telehealth/widgets_basic/material_text_button.dart';

class PatientPaymentCard extends StatelessWidget {
  final VoidCallback onConsultationFeePayment;
  final VoidCallback? onMedicineFeePayment;
  const PatientPaymentCard({Key? key,required this.onConsultationFeePayment, this.onMedicineFeePayment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dr.XYZ on 11/11/22",style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: backgroundColor,
                  ),),
                  Text("10:00AM to 11:30AM"),
                  Text("\$500", style: const TextStyle(
                    color: backgroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),),
                  Align(
                    alignment: Alignment.center,
                    child: MaterialTextButton(
                      buttonName: "Pay consultation fee",
                      onPressed: onConsultationFeePayment,
                    ),
                  ),
                ],
              ),
            ),
            if(onMedicineFeePayment!=null)...[
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
                    const Text("1 Paracetamol: \$400"),
                    Text("\$400", style: TextStyle(
                      color: backgroundColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),),
                    Align(
                      alignment: Alignment.center,
                      child: MaterialTextButton(
                        buttonName: "Purchase Items",
                        onPressed: onMedicineFeePayment,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
