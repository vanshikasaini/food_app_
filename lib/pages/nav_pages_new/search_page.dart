import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quotes_list/widgets/app_search_bar.dart';
import '../../data/response/status.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/routes/screen_arguements.dart';
import '../../view_models/category_viewmodel.dart';
import '../../widgets/app_grid_view.dart';
import '../../widgets/app_text.dart';
import '../../widgets/rating_heart.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchPage extends StatefulWidget {
  final String categoryName;

  const SearchPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return
      AnnotatedRegion<SystemUiOverlayStyle>(
          value:
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, //i like transaparent :-)
            systemNavigationBarColor: Colors.transparent, // navigation bar color
            statusBarIconBrightness: Brightness.dark, // status bar icons' color
            systemNavigationBarIconBrightness:
            Brightness.dark, //navigation bar icons' color
          ),
          child:
          MaterialApp(
            theme: ThemeData(
              primaryColor: Colors.black,
            ),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                color: Colors.black,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                        flex: 10,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 20,
                              child: ElevatedButton(
                                onPressed: () {
                                  debugPrint(
                                      "Passed entered==================================");
                                  Navigator.pop(context);


                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor: Colors.white//<-- SEE HERE
                                  // padding: EdgeInsets.all(20),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 80,
                              child: SearchBarApp(),
                            ),
                          ],
                        )),
                   // Expanded(flex: 90, child: GridViewApp(categoryName: widget.categoryName))
                    Expanded(flex: 90, child: buildGridView(context))
                  ],
                ),
              ),
            ),
          ));
  }

  double _ratingValue = 0.0;
  CategroyListModel categroyListModel = CategroyListModel();
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
  void initState() {
    debugPrint("Passed entered=========initState====222===========");
    categroyListModel.fetchSpecificCategoryDrinkListApi(widget.categoryName);
    super.initState();
  }

  Widget buildGridView(BuildContext parentContext){

      debugPrint("Passed entered===============222===================");
      return ChangeNotifierProvider<CategroyListModel>(
        create: (BuildContext context) => categroyListModel,
        child: Consumer<CategroyListModel>(builder: (context, value, _) {
          switch (value.specificCateListObj.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Text(value.specificCateListObj.message.toString());
            case Status.COMPLETED:
              return GridView.builder(
                  itemCount: value.specificCateListObj.data?.drinks?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            onTap: () {

                              debugPrint("====TAPPED======${value.specificCateListObj.data
                                  ?.drinks?[index].idDrink ??
                                  "23"}=");

                              Navigator.pushNamed(parentContext, RoutesName.detail,arguments: ScreenArguments(
                                value.specificCateListObj.data
                                    ?.drinks?[index].idDrink ??
                                    "23",
                                '',
                              ));

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => DetailScreen(
                              //           id: value.specificCateListObj.data
                              //                   ?.drinks?[index].idDrink ??
                              //               "23")),
                              // );
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(value
                                            .specificCateListObj
                                            .data
                                            ?.drinks?[index]
                                            .strDrinkThumb ??
                                            'images/${mock_images[0]}'),
                                        // AssetImage('images/${mock_images[index]}'),
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
                                    ))),
                          ),
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            AppSmallText(
                              text: value.specificCateListObj.data?.drinks?[index]
                                  .strDrink ??
                                  "Drink",
                              size: 12.0,
                            )
                          ],
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
                                    full: const Icon(Icons.circle,
                                        color: Colors.white),
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

          return Container();
        }),
      );

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
