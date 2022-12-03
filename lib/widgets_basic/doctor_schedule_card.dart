import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:telehealth/const.dart';

class DoctorScheduleCard extends StatelessWidget {
  final String doctorName;
  final String doctorSpecification;
  final double rating;
  final List<dynamic> todaySlotID;
  final List<dynamic> tomorrowSlotID;
  final Function onReserveAppointment;
  const DoctorScheduleCard({Key? key, required this.doctorName, required this.doctorSpecification, required this.rating, required this.todaySlotID, required this.tomorrowSlotID, required this.onReserveAppointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime today=DateTime.now();
    DateTime tomorrow=today.add(const Duration(days: 1));
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
                Text("Dr. $doctorName",style: const TextStyle(
                  color: backgroundColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600
                ),),
                Text(doctorSpecification,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 7,
                    runSpacing: 8,
                    children: [
                      for(int i=0;i<todaySlotID.length;i++)
                        Chip(
                          label: Text("${today.month}/${today.day}/${today.year} ${todaySlotID[i]}:00-${todaySlotID[i]+1}:00"),
                          labelStyle: const TextStyle(
                            color: backgroundColor,
                            fontWeight: FontWeight.w600,
                          ),
                          elevation: 4,
                          deleteButtonTooltipMessage: "Reserve Appointment",
                          deleteIcon: const Icon(Icons.timelapse,color: backgroundColor,),
                          backgroundColor: Colors.transparent,
                          onDeleted: (){
                            onReserveAppointment(today,todaySlotID[i]);
                          },
                        ),
                      for(int i=0;i<tomorrowSlotID.length;i++)
                        Chip(
                          label: Text("${tomorrow.month}/${tomorrow.day}/${tomorrow.year} ${tomorrowSlotID[i]}:00-${tomorrowSlotID[i]+1}:00"),
                          labelStyle: const TextStyle(
                            color: backgroundColor,
                            fontWeight: FontWeight.w600,
                          ),
                          elevation: 4,
                          deleteButtonTooltipMessage: "Reserve Appointment",
                          deleteIcon: const Icon(Icons.timelapse,color: backgroundColor,),
                          backgroundColor: Colors.transparent,
                          onDeleted: (){
                            onReserveAppointment(tomorrow,tomorrowSlotID[i]);
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
