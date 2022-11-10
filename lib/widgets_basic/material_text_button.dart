import 'package:flutter/material.dart';

class MaterialTextButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final Widget? child;
  const MaterialTextButton({Key? key,required this.buttonName,required this.onPressed,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      child: MaterialButton(
        color: Theme.of(context).colorScheme.onTertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: child??Text(buttonName,style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary
          ),),
        ),
      ),
    );
  }
}
