import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quotes_list/pages/navpages/search_page_old.dart';
import 'package:quotes_list/widgets/app_large_text.dart';
import 'package:quotes_list/widgets/app_text.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quotes_list/widgets/rating_heart.dart';

import '../../models/categorieslist.dart';
import '../../widgets/circular_avatar.dart';
import '../../widgets/rating_bar.dart';
import 'package:http/http.dart' as http;

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List food_images = [
    "food1.jpg",
    "food2.jpg",
    "food_3.jpg",
    "food4.jpg",
    "food5.png"
  ];
  List mock_images = [
    "mock_1.jpg",
    "mock_2.jpg",
    "mock_3.jpg",
    "mock_4.jpg",
    "mock_5.jpg",
    "mock_6.jpg",
    "mock_2.jpg",
    "mock_3.jpg",
    "mock_4.jpg",
    "mock_5.jpg",
    "mock_6.jpg"
  ];
  int currentPos = 0;
  late Categories categories;
/*
* Not used
* */
  @override
  void initState() {
    super.initState();
  //  categories = getCategoriesListData() as Categories;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            //Scrolling View
            Stack(
              children: [
                CarouselSlider.builder(
                    itemCount: food_images.length,
                    itemBuilder: (context, itemIndex, _) {
                      return Container(

                          width: double.infinity,
                          height: screenHeight * 0.55,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "images/" + food_images[itemIndex]),
                                fit: BoxFit.cover),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  top: 70.0,
                                  right: 15.0,
                                  bottom: 15.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppSmallText(text: "Featured Recipes"),
                                        SizedBox(
                                          width: 150,
                                          child: AppLargeText(
                                              text: "Harvey Wallbanger"),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            children: const [
                                              AppRatingBar(),
                                              SizedBox(width: 15.0),
                                              AppRatingHeart()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            CircularAvatar(),
                                            const SizedBox(width: 10),
                                            Column(
                                              children: [
                                                AppSmallText(
                                                    text: "John Wintage",
                                                    size: 12.0),
                                                AppSmallText(
                                                    text: "Posted 7hr ago"),
                                              ],
                                            )
                                          ]),
                                        ])
                                  ])));
                    },
                    options: CarouselOptions(
                        autoPlay: true,
                        height: screenHeight * 0.55,
                        // enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        // aspectRatio: 1,
                        initialPage: 0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentPos = index;
                          });
                        })),
                Positioned(
                    right: 0,
                    bottom: 0,
                    //you can use "right" and "bottom" too
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: food_images.map((url) {
                          int index = food_images.indexOf(url);
                          return Container(
                            margin: EdgeInsets.only(
                                left: 2.0, top: 2.0, bottom: 10.0, right: 2.0),
                            width: 8.0,
                            height: 8.0,
                            // padding: EdgeInsets.,
                            //  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPos == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                    ))
              ],
            ),

            //Middle row
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, top: 25.0, right: 15.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLargeText(text: "Today Recipes", size: 20.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage(categoryName: "Cocktail",)),
                      );
                    },
                    child: AppSmallText(
                        text: "View all",
                        color: Colors.grey.withOpacity(0.5),
                        size: 12.0),
                  )
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: getCategoriesListData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return getRecipeListView(snapshot.data!!);
                      } else if (snapshot.hasError) {
                        debugPrint("===============${snapshot.error}");
                        return Text(
                          '${snapshot.error}',
                          style: TextStyle(color: Colors.white),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
          ],
        ));
  }

  Future<Categories> getCategoriesListData() async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'));
    var data = jsonDecode("[" + response.body + "]".toString());
    //  var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      debugPrint("===========200================");

      for (Map<String, dynamic> index in data) {
        // debugPrint(
        //     "===========200====Step1===========${Categories.fromJson(index)}=");
       categories = Categories.fromJson(index);

      }
     // categories = Categories.fromJson(data as Map<String, dynamic>) as Future<Categories>;
      //   debugPrint("===========200=====Step2=========${categories.drinks[0].strCategory}==");
      return categories; //categories; Categories.fromJson(response.body as Map<String, dynamic>);
    } else {
      return categories;
    }
  }

  Widget getRecipeListView(Categories categoriesObj) {
    debugPrint(
        "===========200============${categoriesObj.drinks[0].strCategory}====");
    var listView = ListView.builder(
      padding: EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
      scrollDirection: Axis.horizontal,
      itemCount:categoriesObj.drinks.length,

      itemBuilder: (context, index) {
        return SizedBox(
         // width: 150.0,

          width: MediaQuery
              .of(context)
              .size
              .width * .6,
          child: InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  SearchPage(categoryName:categoriesObj.drinks[index].strCategory)),
              );
            },
            child: Container(
              height: 350.0,
              padding: EdgeInsets.only(right: 15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(18), // Image radius
                  child: Image.asset('images/${mock_images[index]}',
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        );
      },
    );
    return listView;
  }
}

Widget getRecipeListView1() {
  var listView = Container(
    // margin: EdgeInsets.symmetric(vertical: 20.0),
    height: 550.0,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(
          height: 480.0,
          width: 240.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
              size: Size.fromRadius(18), // Image radius
              child: Image.asset('images/mock_1.jpg', fit: BoxFit.cover),
            ),
          ),
        ),
        Container(
          height: 480.0,
          width: 240.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
              size: Size.fromRadius(18), // Image radius
              child: Image.asset('images/mock_2.jpg', fit: BoxFit.cover),
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          //color: Theme.of(context).colorScheme.onBackground,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),

          child: Container(
              height: 480.0,
              width: 240.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(18), // Image radius
                  child: Image.asset('images/mock_3.jpg', fit: BoxFit.cover),
                ),
              )),
        ),
        Container(
          height: 480.0,
          width: 240.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
              size: Size.fromRadius(18), // Image radius
              child: Image.asset('images/mock_4.jpg', fit: BoxFit.cover),
            ),
          ),
        ),
        Container(
          height: 480.0,
          width: 240.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
              size: Size.fromRadius(18), // Image radius
              child: Image.asset('images/mock_5.jpg', fit: BoxFit.cover),
            ),
          ),
        ),
        Container(
          height: 480.0,
          width: 240.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
              size: Size.fromRadius(18), // Image radius
              child: Image.asset('images/mock_6.jpg', fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    ),
  );
  return listView;
}
