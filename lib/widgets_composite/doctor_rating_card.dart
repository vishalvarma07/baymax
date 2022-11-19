import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../widgets_basic/welcome_card.dart';

class DoctorRatingCard extends StatelessWidget {
  const DoctorRatingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WelcomeCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text("Welcome Dr.XYZ!",style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Colors.white
            ),),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Text("Your consultation is rated at 3.6 out of 5",style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.white
                ),),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          RatingBar(
            ratingWidget: RatingWidget(
              empty: const Icon(Icons.star_border_outlined,color: Colors.white,),
              half: const Icon(Icons.star_half,color: Colors.white,),
              full: const Icon(Icons.star,color: Colors.white,),
            ),
            ignoreGestures: true,
            allowHalfRating: true,
            initialRating: 3.4,
            onRatingUpdate: (value){

            },
          ),
        ],
      ),
    );
  }
}
