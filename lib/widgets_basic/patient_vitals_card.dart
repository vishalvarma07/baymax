import 'package:flutter/material.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import '../const.dart';

class PatientVitalsCard extends StatelessWidget {
  final String vitalName;
  final String vitalValue;
  final Color valueStringColor;
  const PatientVitalsCard({Key? key,required this.vitalName,required this.vitalValue, this.valueStringColor=backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 125,
        width: 125,
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Text(vitalName,style: const TextStyle(
              color: backgroundColor,
            ),),
            Center(
              child: Builder(
                builder: (context){
                  if(double.tryParse(vitalValue)!=null){
                    return NumberSlideAnimation(
                      number: vitalValue,
                      duration: const Duration(seconds: 1),
                      textStyle: TextStyle(
                        fontSize: 30,
                        color: valueStringColor,
                      ),
                    );
                  }
                  return Text(vitalValue,style: TextStyle(
                      fontSize: 25,
                      color: valueStringColor
                  ),);
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
