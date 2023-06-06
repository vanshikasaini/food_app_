import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes_list/models/details.dart';
import 'package:quotes_list/pages/navpages/steps_screen.dart';
import 'package:quotes_list/widgets/app_large_text.dart';
import 'package:quotes_list/widgets/app_text.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(DetailScreen(id: "15346",));
}

class DetailScreen extends StatefulWidget {
  final String? id;
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  late Details _details;
  List lst_ingredients = [];
  List lst_steps = [];
  List lst_measure = [];
  List mock_images = [
    "mock_1.jpg",
    "mock_2.jpg",
    "mock_3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    //  double screenWidth = MediaQuery.of(context).size.width;
    return
      MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        // colorScheme: ColorScheme(
        //     background: Colors.black,
        //     brightness: Brightness.dark,
        //     primary: Colors.black)
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(future: getSpecificDrinkData(widget.id ?? "15432"),
          builder: (context,snapshot) {
    if(snapshot.hasData) {
      return
        Column(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                    padding: EdgeInsets.only(left: 25.0, bottom: 25.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: //AssetImage('images/${mock_images[0]}'),
                           NetworkImage(_details.drinks[0]["strDrinkThumb"] ?? 'images/${mock_images[0]}'),
                          fit: BoxFit.fill),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            left: -20,
                            top: 30,
                            child: MaterialButton(
                              onPressed: () {},
                              color: Colors.transparent,
                              textColor: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            )),
                        Positioned(
                            left: 15,
                            bottom: 0,
                            child: AppLargeText(
                              text: _details.drinks[0]['strDrink'] ?? "Drink",
                              size: 40.0,
                            ))
                      ],
                    )

                )),
            Expanded(
              flex: 1,
              child: Padding( //use row
                padding: const EdgeInsets.only(
                    top: 18.0, left: 26.0, right: 18.0, bottom: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text("Ingredients",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ],
                ),
              ),
            ), // E
            Expanded(
                flex: 5,
                child: Stack(children: [
                  ListView.builder(
                      padding:
                      const EdgeInsets.only(left: 25.0,
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
                      bottom: 0,
                      child: FractionallySizedBox(
                          widthFactor: 0.6,
                          alignment: FractionalOffset.bottomCenter,
                          child: InkWell(
                            onTap: (){
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>  StepsPage(),
                              // ));
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 15.0),
                                margin: EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                                child: const Text(
                                  'Start Mixing',
                                  textAlign: TextAlign.center,
                                )),
                          )

                        // ElevatedButton(
                        //   child: Text('Start Mixing'),
                        //
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.yellow,
                        //     elevation:5.0,
                        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                        //   ),
                        //   onPressed: () {},
                        // )
                      ))
                ])

            ),
          ],
        );
    }
    else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }
          }
        ),
      ),
    );
  }
  Future<Details> getSpecificDrinkData(String drink_id) async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$drink_id'));

    var data = jsonDecode(response.body.toString());
   // var data = jsonDecode("[" + response.body + "]".toString());
    if (response.statusCode == 200) {
      // for (Map<String, dynamic> index in data) {
      _details = Details.fromJson(data);
    //   }

      for( var i=1;i<=15;i++){
        if(_details.drinks[0]["strIngredient$i"]!= null){
          lst_ingredients.add(_details.drinks[0]["strIngredient$i"]);
        }
        if(_details.drinks[0]["strMeasure$i"]!= null){
          lst_measure.add(_details.drinks[0]["strMeasure$i"]);
        }
      }
      print("Details Response ${_details.drinks[0]['idDrink']}");
      return _details;
    } else {
      return _details;
    }
  }

}
