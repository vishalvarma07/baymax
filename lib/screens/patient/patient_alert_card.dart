import 'package:flutter/material.dart';

class PatientAlertCard extends StatelessWidget {
  final Widget leading;
  final Widget text;
  final Widget? action;
  const PatientAlertCard({Key? key, required this.leading, required this.text, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            leading,
            const SizedBox(
              width: 4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text,
                action??Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}
