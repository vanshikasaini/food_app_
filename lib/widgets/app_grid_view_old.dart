import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes_list/widgets/app_circle_rating.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quotes_list/widgets/rating_heart.dart';
import '../models/demodart.dart';
import '../models/sample.dart';
//import '../models/specificCatelistModel.dart';
import '../pages/navpages/detail_screen_old.dart';
import 'app_text.dart';
import 'package:http/http.dart' as http;

/// nto run demo must wrap Gridview with
/// Scaffold widget
// void main() {
//   runApp(GridViewApp());
// }

class GridViewApp extends StatefulWidget {
  final String categoryName;
  const GridViewApp({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<GridViewApp> createState() => _GridViewAppState();
}

class _GridViewAppState extends State<GridViewApp> {
  List<SpecificCateList> specificList = [];
  late SpecificCateList specificListData ;
  List<Sample> sampleList = [];
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
    debugPrint( "Passed entered===============222===================");
    return    FutureBuilder(
        future:getSpecificListData(widget.categoryName),// ,getData()
        builder: (context,snapshot){
     if(snapshot.hasData){
     //  debugPrint("===============${specificList.toString()}");
       //debugPrint("===============${sampleList[0].name}");
       debugPrint("===============${specificListData.drinks?[0].strDrink}");

       return GridView.builder(
           itemCount: mock_images.length,
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2,
               childAspectRatio: 2 / 3,
               mainAxisSpacing: 20.0,
               crossAxisSpacing: 10.0),
           itemBuilder: (context, index) {
             return Column(
               //Stack(
               children: [
                 Expanded(
                   flex: 6,
                   child: InkWell(
                     onTap:(){
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) =>  DetailScreen(id:specificListData.drinks?[index].idDrink ?? "23")),
                       );
                     }


                     ,
                     child: Container(


                         decoration: BoxDecoration(
                             image: DecorationImage(
                                 image: NetworkImage(specificListData.drinks?[index].strDrinkThumb ?? 'images/${mock_images[0]}'),// AssetImage('images/${mock_images[index]}'),
                                 fit: BoxFit.fill),
                             borderRadius: BorderRadius.circular(10.0)),
                         child: Align(
                             alignment: Alignment.bottomRight,

                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Row(

                                 mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   AppRatingHeart(),
                                 ],
                               ),
                             )

                         )
                     ),
                   ),
                 ),
                 Wrap(
                   alignment: WrapAlignment.center,
                   children: [AppSmallText(
                     text: specificListData.drinks?[index].strDrink ?? "Drink",
                     size: 12.0,
                   )],
                 ),
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

                     AppSmallText(
                       text: _ratingValue != 0.0
                           ? getRatingTitle(_ratingValue.toString())
                           : 'Rate it!',
                       size: 12.0,
                     ),
                   ],
                 ),
               ],
             );
           });
    }
     else {
       return Center(
         child: CircularProgressIndicator(),
       );
     }
    });
  }
  Future<SpecificCateList> getSpecificListData(String categoryName) async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=$categoryName'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
     // for (Map<String, dynamic> index in data) {
      specificListData = SpecificCateList.fromJson(data);
     // }
      return specificListData;
    } else {
      return specificListData;
    }
  }
  Future<List<SpecificCateList>> getSpecificListDataOld() async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'));
    var data  =  jsonDecode("[" + response.body + "]".toString());
 //   var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        specificList.add(SpecificCateList.fromJson(index));
      }
      return specificList;
    } else {
      return specificList;
    }
  }

  Future<List<Sample>> getData() async {

    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        sampleList.add(Sample.fromJson(index));
      }
      return sampleList;
    } else {
      return sampleList;
    }
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
