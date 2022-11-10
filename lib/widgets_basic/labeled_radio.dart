import 'package:flutter/material.dart';

class LabelRadioButton extends StatelessWidget {
  final dynamic representedValue, currentValue;
  final Function onChanged;
  final String label;
  const LabelRadioButton({Key? key, required this.label, this.representedValue, this.currentValue,required this.onChanged,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: representedValue,
          groupValue: currentValue,
          onChanged: (value){
            onChanged(value);
          },
        ),
        Text(label),
      ],
    );
  }
}
