import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/navpages/search_page_old.dart';

class AppSmallText extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppSmallText(
      {Key? key,
      required this.text,
      this.size = 10.0,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
          text,
          style:
          TextStyle(fontSize: size, color: color, fontWeight: FontWeight.bold,decoration: TextDecoration.none),

        );
  }
}

//MaterialApp(
//       home: InkWell(
//         onTap: (){
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const SearchPage()),
//           );
//         },
//         child: Text(
//           text,
//           style:
//           TextStyle(fontSize: size, color: color, fontWeight: FontWeight.bold),
//
//         ),
//       ),
//     );
