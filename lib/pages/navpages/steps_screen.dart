import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quotes_list/utils/routes/stepa_arguements.dart';

import '../../widgets/app_text.dart';
void main() {
 // runApp(StepsPage());
}
class StepsPage extends StatefulWidget {
 // final String imageUrl;
  const StepsPage({Key? key}) : super(key: key);

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  List steps = ["1. Blend with ice.", "2. Serve in a wine glass." ,"3. Garnish with carrot."];
  List mock_images = [
    "mock_1.jpg",
    "mock_2.jpg",
    "mock_3.jpg",
  ];


  @override
  Widget build(BuildContext context) {
    StepsArguments stepsArguments= ModalRoute.of(context)!.settings.arguments as StepsArguments;
    return
      // MaterialApp(
      // debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor: Colors.black,
      //   // colorScheme: ColorScheme(
      //   //     background: Colors.black,
      //   //     brightness: Brightness.dark,
      //   //     primary: Colors.black)
      // ),
      // home:

      Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                    padding: EdgeInsets.only(left: 25.0, bottom: 25.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                           NetworkImage(stepsArguments.imagesUrl ?? 'images/${mock_images[0]}'),////AssetImage('images/${mock_images[0]}'),
                          fit: BoxFit.fill),
                    ),
                    child: Container()


                )),
            Expanded(
              flex: 1,
              child:  Padding(//use row
                padding: const EdgeInsets.only(top: 18.0,left: 26.0,right: 18.0,bottom: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Steps",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ],
                ),
              ),
            ), // E
            Expanded(
                flex: 5,
                child:
                  ListView.builder(
                      padding:
                      EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0,bottom: 100.0),
                      scrollDirection: Axis.vertical,
                      itemCount: steps.length,
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            children: [AppSmallText(
                            text: steps[index],
                            size: 12.0,
                            ),]
                          ),
                        );
                      }),
                )

            
          ],
        ),
      );
    // ,
    // );
  }
}
