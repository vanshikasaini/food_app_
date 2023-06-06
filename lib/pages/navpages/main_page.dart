import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes_list/pages/navpages/create_page.dart';
import 'package:quotes_list/pages/navpages/profile_page.dart';

import '../nav_pages_new/discover.dart';
import '../nav_pages_new/search_page.dart';
import '../nav_pages_new/shopping_page.dart';
// import 'package:quotes_list/pages/navpages/search_page_old.dart';
// import 'package:quotes_list/pages/navpages/shopping_page_old.dart';
// import 'dicover_old.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // List pages = [
  //   DiscoverPage(),
  //   SearchPage(categoryName: "Cocktail"),
  //   CreatePage(),
  //   ShoppingPage(),
  //   ProfilePage()
  // ];
  List pages = [
    DiscoverPage(),
    SearchPage(categoryName: "Cocktail"),
    CreatePage(),
    ShoppingPage(),
    ProfilePage()
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.black87, // navigation bar color
          statusBarIconBrightness: Brightness.dark, // status bar icons' color

          systemNavigationBarIconBrightness:
              Brightness.dark, //navigation bar icons' color
        ),
        child: Scaffold(
          //   backgroundColor: Colors.black,
          body: pages[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            onTap: onTap,
            currentIndex: currentIndex,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black87,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "Discover"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.create), label: "Create"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag), label: "Shopping"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile")
            ],
          ),
        ));
  }
}
