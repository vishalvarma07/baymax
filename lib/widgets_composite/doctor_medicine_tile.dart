import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telehealth/widgets_basic/round_material_button.dart';


class DoctorMedicineTile extends StatelessWidget {
  final String medicine;
  final int value;
  final VoidCallback plusOnPress;
  final VoidCallback minusOnPress;
  const DoctorMedicineTile({Key? key, required this.medicine, required this.value, required this.plusOnPress, required this.minusOnPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(medicine),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundMaterialButton(
            onPressed: plusOnPress,
            child: const Icon(FontAwesomeIcons.plus,color: Colors.white,),
          ),
          Text(value.toString()),
          RoundMaterialButton(
            onPressed: minusOnPress,
            child: const Icon(FontAwesomeIcons.minus,color: Colors.white,),
          ),
        ],
      ),
    );
  }
}
