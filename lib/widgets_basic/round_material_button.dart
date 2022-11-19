import 'package:flutter/material.dart';

import '../const.dart';

class RoundMaterialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const RoundMaterialButton({Key? key, required this.onPressed, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const CircleBorder(),
      color: backgroundColor,
      onPressed: onPressed,
      child: child,
    );
  }
}
