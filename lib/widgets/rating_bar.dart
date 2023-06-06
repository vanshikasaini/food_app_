import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quotes_list/widgets/app_text.dart';

class AppRatingBar extends StatefulWidget {

  const AppRatingBar({Key? key}) : super(key: key);

  @override
  State<AppRatingBar> createState() => _AppRatingBarState();
}

class _AppRatingBarState extends State<AppRatingBar> {
  double _ratingValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        // implement the rating bar
        RatingBar(
            itemSize: 10.0,
            initialRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            ratingWidget: RatingWidget(
                full: const Icon(Icons.star, color: Colors.white),
                half: const Icon(
                  Icons.star_half,
                  color: Colors.white,
                ),
                empty: const Icon(
                  Icons.star_outline,
                  color: Colors.white,
                )),
            onRatingUpdate: (value) {
              setState(() {
                _ratingValue = value;
              });
            }),
        const SizedBox(width: 5.0),

        AppSmallText(
          text: _ratingValue != 0.0
              ? getRatingTitle(_ratingValue.toString())
              : 'Rate it!',
          size: 12.0,
        ),

      ],
    ));
  }

  String getRatingTitle(String _ratingValue) {
    if (double.parse(_ratingValue) <= 2) {
      return "Weak";
    } else if (double.parse(_ratingValue) <= 4 &&
        double.parse(_ratingValue) >= 3) {
      return "Good";
    } else if (double.parse(_ratingValue) > 4) {
      return "Strong";
    } else {
      return "0.0";
      //return "Taste & Rate it!";
    }
  }
}
