import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyScreenPlaceholder extends StatelessWidget {
  final IconData iconData;
  final String text;
  const EmptyScreenPlaceholder({Key? key,required this.iconData, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData,color: Colors.grey,),
        Text(text,style: const TextStyle(
            color: Colors.grey
        ),),
      ],
    );
  }
}
