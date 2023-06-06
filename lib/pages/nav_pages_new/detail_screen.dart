import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_list/models/details.dart';
import 'package:quotes_list/pages/navpages/steps_screen.dart';
import 'package:quotes_list/widgets/app_large_text.dart';
import 'package:quotes_list/widgets/app_text.dart';
import '../../data/response/status.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/routes/screen_arguements.dart';
import '../../utils/routes/stepa_arguements.dart';
import '../../view_models/category_viewmodel.dart';

void main() {
  // runApp(DetailScreen(id: "15346",));
}

class DetailScreen extends StatefulWidget {
  final String id;

  const DetailScreen({Key? key, required this.id}) : super(key: key);

  // const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List lst_ingredients = [];
  List lst_steps = [];
  List lst_measure = [];
  List mock_images = [
    "mock_1.jpg",
    "mock_2.jpg",
    "mock_3.jpg",
  ];
  CategroyListModel categroyListModel = CategroyListModel();

  @override
  void initState() {
    categroyListModel.fetchDrinkDetailApi(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  double screenWidth = MediaQuery.of(context).size.width;

    //hide today 5 june 2023
    // ScreenArguments stepsArguments= ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    // categroyListModel.fetchDrinkDetailApi(stepsArguments.title);
    return
        // MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   theme: ThemeData(
        //     primaryColor: Colors.black,
        //     // colorScheme: ColorScheme(
        //     //     background: Colors.black,
        //     //     brightness: Brightness.dark,
        //     //     primary: Colors.black)
        //   ),
        //   home:
        Scaffold(
            backgroundColor: Colors.black,
            body: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.steps,
                      arguments: StepsArguments("Hello"));
                },
                //   child: Center(child: Text("Hello${widget.id}",style: TextStyle(color: Colors.white),)),
                //  // child: Center(child: Text("Hello${stepsArguments.title}",style: TextStyle(color: Colors.white),)),
                // )

                child: ChangeNotifierProvider<CategroyListModel>(
                  create: (BuildContext context) => categroyListModel,
                  child:

                  Consumer<CategroyListModel>(builder: (context, value, _) {
                    switch (value.drinkDetailObj.status) {
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                      case Status.ERROR:
                        return Text(value.drinkDetailObj.message.toString());
                      case Status.COMPLETED:
                        getSpecificDrinkData(value.drinkDetailObj.data);
                        return Column(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left: 25.0, bottom: 25.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: //AssetImage('images/${mock_images[0]}'),
                                              NetworkImage(value.drinkDetailObj
                                                          .data?.drinks[0]
                                                      ["strDrinkThumb"] ??
                                                  'images/${mock_images[0]}'),
                                          fit: BoxFit.fill),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            left: -10,
                                            top: 30,
                                            child:
                                                // MaterialButton(
                                                //   onPressed: () {},
                                                //   color: Colors.transparent,
                                                //   textColor: Colors.white,
                                                //   child: InkWell(
                                                //     onTap: () {
                                                //       Navigator.pop(context);
                                                //     },
                                                //     child: Container(
                                                //       width: 25,
                                                //       height: 25,
                                                //       decoration: BoxDecoration(
                                                //         shape: BoxShape.circle,
                                                //         color: Colors.transparent,
                                                //       ),
                                                //       child: Icon(
                                                //         Icons.close,
                                                //         size: 20,
                                                //         color: Colors.white,
                                                //       ),
                                                //     ),
                                                //   ),
                                                //   padding: EdgeInsets.all(16),
                                                //   shape: CircleBorder(),
                                                // )
                                                ElevatedButton(
                                              onPressed: () {
                                                debugPrint(
                                                    "Passed entered==================================");
                                                //Navigator.pop(context);
                                                Navigator.of(context).pop();
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  shape: CircleBorder(),
                                                  backgroundColor: Colors
                                                      .black87
                                                      .withOpacity(
                                                          0.5) //<-- SEE HERE
                                                  // padding: EdgeInsets.all(20),
                                                  ),
                                            )),
                                        Positioned(
                                          left: 0,
                                          bottom: 0,

                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                value.drinkDetailObj.data
                                                            ?.drinks[0]
                                                        ['strDrink'] ??
                                                    "Drink",
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 40.0,
                                                  fontFamily: 'Roboto',
                                                  color: Color(0xFF212121),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),

                                          // AppLargeText(
                                          //   text: value.drinkDetailObj.data
                                          //           ?.drinks[0]['strDrink'] ??
                                          //       "Drink",
                                          //   size: 40.0,
                                          // )
                                        )
                                      ],
                                    ))),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                //use row
                                padding: const EdgeInsets.only(
                                    top: 18.0,
                                    left: 26.0,
                                    right: 18.0,
                                    bottom: 18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text("Ingredients",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0)),
                                  ],
                                ),
                              ),
                            ), // E
                            Expanded(
                                flex: 5,
                                child: Stack(children: [
                                  ListView.builder(
                                      padding: const EdgeInsets.only(
                                          left: 25.0,
                                          top: 15.0,
                                          right: 25.0,
                                          bottom: 100.0),
                                      scrollDirection: Axis.vertical,
                                      itemCount: lst_ingredients.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color: Colors.blueGrey,
                                          child: ListTile(
                                            title: AppSmallText(
                                              text: lst_ingredients[index],
                                              size: 12.0,
                                            ),
                                            subtitle: AppSmallText(
                                              text: lst_measure[index],
                                              size: 10.0,
                                            ),
                                          ),
                                        );
                                      }),
                                  Positioned(
                                      //    width: screenWidth * 0.5 ,
                                      right: 0,
                                      left: 0,
                                      bottom: 40,
                                      child: FractionallySizedBox(
                                          widthFactor: 0.6,
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, RoutesName.steps,
                                                  arguments: StepsArguments(value
                                                              .drinkDetailObj
                                                              .data
                                                              ?.drinks[0]
                                                          ["strDrinkThumb"] ??
                                                      'images/${mock_images[0]}'));
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 15.0),
                                                margin: EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                    color: Colors.orangeAccent,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30.0))),
                                                child: const Text(
                                                  'Start Mixing',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                )),
                                          )))
                                ])),
                          ],
                        );
                        ;
                    }

                    return Container();
                  }),
                )));
    //,
    //   );
  }

  void getSpecificDrinkData(Details? _details) {
    for (var i = 1; i <= 15; i++) {
      if (_details?.drinks[0]["strIngredient$i"] != null) {
        lst_ingredients.add(_details?.drinks[0]["strIngredient$i"]);
      }
      if (_details?.drinks[0]["strMeasure$i"] != null) {
        lst_measure.add(_details?.drinks[0]["strMeasure$i"]);
      }
    }
    print("Details Response ${_details?.drinks[0]['idDrink']}");
  }
}
