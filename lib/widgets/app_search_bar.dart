import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//import '../models/specificCatelistModel.dart';

class SearchBarApp extends StatefulWidget {
  SearchBarApp({Key? key}) : super(key: key);

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
 // List<SpecificCateList> specificList = [];

  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                // Add padding around the search bar
                // padding: const EdgeInsets.symmetric(horizontal: 8.0),
                // Use a Material design search bar
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                    hintText: 'Search...',
                    // Add a clear button to the search bar
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
                    ),
                    // Add a search icon or button to the search bar
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Perform the search here
                      },
                    ),
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            );


  }

  // Future<List<SpecificCateList>> getSpecificListData() async {
  //   final response = await http.get(Uri.parse(
  //       'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'));
  //   var data = jsonDecode(response.body.toString());
  //
  //   if (response.statusCode == 200) {
  //     for (Map<String, dynamic> index in data) {
  //       specificList.add(SpecificCateList.fromJson(index));
  //     }
  //     return specificList;
  //   } else {
  //     return specificList;
  //   }
  // }
}
