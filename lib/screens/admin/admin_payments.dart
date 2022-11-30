import 'package:flutter/material.dart';
import 'package:telehealth/widgets_composite/admin_payment_card.dart';

class AdminPayments extends StatefulWidget {
  const AdminPayments({Key? key}) : super(key: key);

  @override
  State<AdminPayments> createState() => _AdminPaymentsState();
}

class _AdminPaymentsState extends State<AdminPayments> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminPaymentCard(),
      ],
    );
  }
}
