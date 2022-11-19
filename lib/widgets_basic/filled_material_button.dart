import 'package:flutter/material.dart';
import 'package:telehealth/const.dart';

class FilledMaterialButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const FilledMaterialButton({Key? key, required this.child, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
