import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_list/data/response/status.dart';
import 'package:quotes_list/pages/navpages/search_page_old.dart';
import 'package:quotes_list/utils/routes/routes_name.dart';
import 'package:quotes_list/widgets/app_large_text.dart';
import 'package:quotes_list/widgets/app_text.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quotes_list/widgets/rating_heart.dart';

import '../../models/categorieslist.dart';
import '../../utils/routes/screen_arguements.dart';
import '../../view_models/category_viewmodel.dart';
import '../../widgets/circular_avatar.dart';
import '../../widgets/rating_bar.dart';

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
  CategroyListModel categroyListModel = CategroyListModel();

  @override
  void initState() {
    categroyListModel.fetchCategoriesListApi();
    super.initState();
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
                      Navigator.pushNamed(context, RoutesName.search,
                          arguments: ScreenArguments(
                            'Cocktail',
                            '',
                          ));


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
                child: ChangeNotifierProvider<CategroyListModel>(
              create: (BuildContext context) => categroyListModel,
              child: Consumer<CategroyListModel>(builder: (context, value, _) {
                switch (value.categoriesList.status) {
                  case Status.LOADING:
                    return Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Text(value.categoriesList.message.toString());
                  case Status.COMPLETED:
                    return getRecipeListView(value.categoriesList.data!!);
                }

                return Container();
              }),
            ) //

                ),
          ],
        ));
  }

  Widget getRecipeListView(Categories categoriesObj) {
    debugPrint(
        "===========200============${categoriesObj.drinks[0].strCategory}====");
    var listView = ListView.builder(
      padding: EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
      scrollDirection: Axis.horizontal,
      itemCount: categoriesObj.drinks.length,
      itemBuilder: (context, index) {
        return SizedBox(
          // width: 150.0,

          width: MediaQuery.of(context).size.width * .6,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.search,
                  arguments: ScreenArguments(
                    categoriesObj.drinks[index].strCategory,
                    '',
                  ));

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
