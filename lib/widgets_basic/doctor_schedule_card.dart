import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telehealth/const.dart';

class DoctorScheduleCard extends StatelessWidget {
  const DoctorScheduleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          RatingBar(
            ratingWidget: RatingWidget(
              empty: const Icon(Icons.star_border_outlined,color: backgroundColor,),
              half: const Icon(Icons.star_half,color: backgroundColor,),
              full: const Icon(Icons.star,color: backgroundColor,),
            ),
            ignoreGestures: true,
            onRatingUpdate: (value){

            },
          ),
          const SizedBox(
            height: 100,
            child: VerticalDivider(
              indent: 8,
              endIndent: 8,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dr. XYZ",style: TextStyle(
                  color: backgroundColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600
                ),),
                Text("General Physician",),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 7,
                    runSpacing: 8,
                    children: [
                      for(int i=0;i<20;i++)
                        Chip(
                          label: Text("11/${i+1}/2022 1:00PM-2:30PM"),
                          labelStyle: const TextStyle(
                            color: backgroundColor,
                            fontWeight: FontWeight.w600,
                          ),
                          elevation: 4,
                          deleteIcon: Icon(Icons.timelapse,color: backgroundColor,),
                          backgroundColor: Colors.transparent,
                          onDeleted: (){

                          },
                        ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
