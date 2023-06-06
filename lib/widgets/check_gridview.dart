import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes_list/widgets/app_circle_rating.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quotes_list/widgets/rating_heart.dart';
import 'app_text.dart';

void main() {
  runApp(AppGridView());
}

class AppGridView extends StatelessWidget {
  AppGridView({Key? key}) : super(key: key);

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
  double _ratingValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        padding: EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: mock_images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4.0,
              mainAxisSpacing: 5.0,childAspectRatio: 2/3),
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                SizedBox(
                  //  width: double.infinity,
                  //   height: 550.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
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

                        AppSmallText(
                          text: _ratingValue != 0.0
                              ? getRatingTitle(_ratingValue.toString())
                              : 'Rate it!',
                          size: 12.0,
                        ),

                      ],
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/${mock_images[index]}'))),
                    child:  Align(
                        alignment: Alignment.bottomRight,
                        child: Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            //you can use "right" and "bottom" too
                            child: Row( mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppRatingHeart(),
                              ],
                            )

                          // Text(
                          //        "View all",
                          //       style: TextStyle(fontSize: 12.0,decoration: TextDecoration.none))

                        ))

                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(10), // Image border
                  //   child: SizedBox.fromSize(
                  //     size: Size.fromRadius(18), // Image radius
                  //     child: Image.asset(
                  //         'images/${mock_images[index]}', fit: BoxFit.cover),
                  //   ),
                  // ),
                ),





                // AppCircleRating()
                //  Row(
                //    children: [
                //      // implement the rating bar
                //      RatingBar(
                //          itemSize: 10.0,
                //          initialRating: 0,
                //          direction: Axis.horizontal,
                //          allowHalfRating: true,
                //          itemCount: 5,
                //          ratingWidget: RatingWidget(
                //              full: const Icon(Icons.circle, color: Colors.white),
                //              half: const Icon(
                //                Icons.circle,
                //                color: Colors.white,
                //              ),
                //              empty: const Icon(
                //                Icons.circle_outlined,
                //                color: Colors.white,
                //              )),
                //          onRatingUpdate: (value) {
                //            // setState(() {
                //            //   _ratingValue = value;
                //            // });
                //          }),
                //      const SizedBox(width: 5.0),
                //
                //      AppSmallText(
                //        text: _ratingValue != 0.0
                //            ? getRatingTitle(_ratingValue.toString())
                //            : 'Rate it!',
                //        size: 12.0,
                //      ),
                //
                //    ],)
              ],
            );
          },
        ),
      ),
    );
  }


  //
  // Positioned(left: -1.0,
  //                       right: -1.0,
  //                       bottom: -1.0,
  //                       child: AppSmallText(
  //                           text: "View all",
  //                           color: Colors.white,size: 12.0),
  //                     ),


  /*
  *    Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    //you can use "right" and "bottom" too
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "Name to search",
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                )*/

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
