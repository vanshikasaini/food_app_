import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import 'app_text.dart';

class AppRatingHeart extends StatefulWidget {
  const AppRatingHeart({Key? key}) : super(key: key);

  @override
  State<AppRatingHeart> createState() => _AppRatingHeartState();
}

class _AppRatingHeartState extends State<AppRatingHeart> {
  int _ratingValue = 340;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        // implement the rating bar
        getHeartImage(_ratingValue),
        const SizedBox(width: 5.0),

        AppSmallText(
          text: _ratingValue != 0 ? _ratingValue.toString() : 'Like it!',
          size: 12.0,

        ),
      ],
    ));
  }

  Widget getHeartImage(int _ratingValue) {
    if (_ratingValue != 0) {
      return Container(
        width: 20.0,
        height: 20.0,
        child: SvgPicture.asset(
          "images/heart_filled.svg", //asset location
          color: Colors.white, //svg color
        ),
      );
    } else {
    return  Container(
      width: 20.0,
      height: 20.0,
        child: SvgPicture.asset(
          "images/heart_empty.svg", //asset location
          color: Colors.white, //svg color
        ),
      );
    }
  }

}
