import 'package:flutter/material.dart';
import 'package:telehealth/widgets_composite/admin_payment_card.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminPaymentCard()
      ],
    );
  }
}
