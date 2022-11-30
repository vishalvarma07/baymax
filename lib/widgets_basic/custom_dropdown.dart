import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final bool takeFullWidth;
  final Function onChanged;
  final String? value;
  final Map<String,String> menuOptions;
  const CustomDropdown({Key? key,required this.menuOptions, required this.onChanged, this.value, this.takeFullWidth=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: takeFullWidth?double.infinity:300,
      child: DropdownButtonFormField(
        value: value,
        items: [
          for(int i=0;i<menuOptions.keys.toList().length;i++)
            DropdownMenuItem(value: menuOptions[menuOptions.keys.toList()[i]],child: Text(menuOptions.keys.toList()[i]),)
        ],
        onChanged: (String? value){
          onChanged(value);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          )
        ),
      ),
    );
  }
}
