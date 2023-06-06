import 'package:flutter/material.dart';
import 'package:quotes_list/pages/nav_pages_new/detail_screen.dart';
import 'package:quotes_list/pages/nav_pages_new/search_page.dart';
import 'package:quotes_list/pages/navpages/main_page.dart';
import 'package:quotes_list/pages/navpages/shopping_page_old.dart';
import 'package:quotes_list/pages/navpages/steps_screen.dart';
import 'package:quotes_list/utils/routes/routes_name.dart';
import 'package:quotes_list/utils/routes/screen_arguements.dart';
import 'package:quotes_list/utils/routes/stepa_arguements.dart';

import '../../pages/nav_pages_new/discover.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.mainPage:
        return MaterialPageRoute(builder: (BuildContext context) => MainPage());
      case RoutesName.discover:
        return MaterialPageRoute(
            builder: (BuildContext context) => DiscoverPage());
      case RoutesName.shoping:
        return MaterialPageRoute(
            builder: (BuildContext context) => ShoppingPage());
      case RoutesName.search:
        return MaterialPageRoute(
            builder: (BuildContext context) => SearchPage(
                categoryName: (settings.arguments as ScreenArguments).title));
      case RoutesName.detail:
        //final ScreenArguments args =(settings.arguments as ScreenArguments);
        return MaterialPageRoute(
            builder: (BuildContext context) => DetailScreen(
                id: (settings.arguments as ScreenArguments).title));
        // return MaterialPageRoute(
        //     builder: (BuildContext context) => DetailScreen(),settings: RouteSettings(arguments: args));
        case RoutesName.steps:
          final StepsArguments args =(settings.arguments as StepsArguments);

        return MaterialPageRoute(
            builder: (BuildContext context) => StepsPage(),settings: RouteSettings(arguments: args));

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text("No routes "),
            ),
          );
        });
    }
  }
}
