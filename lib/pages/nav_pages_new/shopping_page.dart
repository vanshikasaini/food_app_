import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes_list/widgets/app_large_text.dart';
import 'package:quotes_list/widgets/app_menupopup_items.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ShoppingPage(),
  ));
}

class ShoppingPage extends StatefulWidget {
  ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  List mock_images = [
    "mock_1.jpg",
    "mock_2.jpg",
    "mock_3.jpg",
  ];
  List ingredientsName = [
    "Blanco Tequila",
    "Orange liqueur",
    "Fig syrup",
    "honey",
    "triple sec",
    "club soda ",
    "sugar",

  ];
  String? selectedIngredient; //no

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [AppMenuPopup()],
      ),
      body: Container(
        padding: const EdgeInsets.only(
            left: 20.0, top: 30.0, right: 20.0, bottom: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: AppLargeText(
                  text: "Shopping List",
                  size: 30.0,
                  color: Colors.white,
                )),
            // Divider(height: 10.0,color: Colors.white,),
            Expanded(
                flex: 7,
                child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: mock_images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          // image: DecorationImage(
                          //     image: AssetImage('images/${mock_images[0]}'),
                          //     // ,NetworkImage(specificListData.drinks?[index].strDrinkThumb ?? 'images/${mock_images[0]}')
                          //     fit: BoxFit.fill),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 30.0,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                  image: DecorationImage(
                                      image: AssetImage('images/food1.jpg'),
                                      // ,NetworkImage(specificListData.drinks?[index].strDrinkThumb ?? 'images/${mock_images[0]}')
                                      fit: BoxFit.fill),
                                ),
                                child: null,
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 28.0, top: 8.0, bottom: 8.0),
                                  child: AppLargeText(
                                    text: "Fresh Fig Margarita",
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                )),
                            Expanded(
                                flex: 5,
                                child: ListView.builder(
                                    itemCount: ingredientsName.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0, top: 8.0, bottom: 8.0),

                                        //Column(children: [
                                        child: RadioListTile(
                                          title: Text("${ingredientsName[index]}"),
                                          value: ingredientsName[index],
                                          groupValue: selectedIngredient,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedIngredient =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                        //  Divider(),
                                        //]);
                                      );
                                    })),
                            // const Spacer(
                            //   flex: 1,
                            // ),
                            SizedBox(
                              height: 15.0,
                              child: null,
                            )
                          ],
                        ),
                      );
                    })
            ),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
