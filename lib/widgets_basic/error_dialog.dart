import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;
  const ErrorDialog({Key? key,required this.title, required this.content, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text("OK"),
        ),
      ],
    );
  }
}
