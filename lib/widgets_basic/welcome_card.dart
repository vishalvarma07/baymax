import 'package:flutter/material.dart';
import 'package:telehealth/const.dart';

class WelcomeCard extends StatelessWidget {
  final Widget? child;
  const WelcomeCard({Key? key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [backgroundColor,seedColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          )
        ),
        child: child,
      ),
    );
  }
}
