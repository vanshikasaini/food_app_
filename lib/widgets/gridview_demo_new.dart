import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quotes_list/widgets/rating_heart.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'app_text.dart';


void main() {
  runApp(MaterialApp(
    title: "Demo Gride view",
    home: GridViewApp(),
  ));
}

class GridViewApp extends StatefulWidget {

  const GridViewApp({Key? key}) : super(key: key);

  @override
  State<GridViewApp> createState() => _GridViewAppState();
}

class _GridViewAppState extends State<GridViewApp> {
  double _ratingValue = 0.0;
  List mock_images = [
    "mock_1.jpg",
    "mock_2.jpg",
    "mock_3.jpg",
    "mock_4.jpg",
    "mock_5.jpg",
    "mock_6.jpg",
    "mock_1.jpg",
    "mock_2.jpg",
    "mock_3.jpg",
    "mock_4.jpg",
    "mock_5.jpg",
    "mock_6.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grid View"),),
      body: Container(
        child: GridView.builder(
            itemCount: mock_images.length,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 2 / 3,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0
            ), itemBuilder: (context, index) {
          return Column( //Stack(
            children: [
              Expanded(

              flex: 6,
                child:  Container(
                  // width: double.infinity,
                  //height: 250.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/${mock_images[index]}'),
                            fit: BoxFit.fill

                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            //you can use "right" and "bottom" too
                            child: Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppRatingHeart(),
                              ],
                            )

                        ))


                ),
              )
             ,
              Text("MockTail Name"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // implement the rating bar
                  RatingBar(
                      itemSize: 10.0,
                      initialRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.circle, color: Colors.white),
                          half: const Icon(
                            Icons.circle,
                            color: Colors.white,
                          ),
                          empty: const Icon(
                            Icons.circle_outlined,
                            color: Colors.white,
                          )),
                      onRatingUpdate: (value) {
                        // setState(() {
                        //   _ratingValue = value;
                        // });
                      }),
                  const SizedBox(width: 5.0),
Text("Rune",style: TextStyle(
  fontSize: 12.0,color:Colors.purple
),)
                  // AppSmallText(
                  //   text: _ratingValue != 0.0
                  //       ? getRatingTitle(_ratingValue.toString())
                  //       : 'Rate it!',
                  //   size: 12.0,
                  // ),

                ],
              ),
            ],
          );
        }),
      ),
    );
  }
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
