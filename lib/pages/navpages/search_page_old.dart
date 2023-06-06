import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes_list/widgets/app_search_bar.dart';
import 'package:http/http.dart' as http;
import '../../models/specificCatelistModel.dart';
import '../../widgets/app_grid_view_old.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget {
  final String categoryName;

  const SearchPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SpecificCateList> specificList=[];
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
              Expanded(flex: 90, child: GridViewApp(categoryName: widget.categoryName))
            ],
          ),
        ),
      ),
    ));
  }

  Future<List<SpecificCateList>> getSpecificListData() async{
    final response =await http.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'));
    var data=jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String,dynamic> index in data){
        specificList.add(SpecificCateList.fromJson(index));
      }
      return specificList;
    } else{
      return specificList;
    }
  }
}
