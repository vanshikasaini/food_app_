import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
 double size;
 final String text;
  //TextAlign _textAlign;
 final Color color;

   AppLargeText({Key? key,
     required this.text,
      this.size=30.0,
      this.color=Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
      TextStyle(
          fontSize: size,
          color: color,
      ),

    );
  }
}
