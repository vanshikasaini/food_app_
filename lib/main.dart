import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quotes_list/pages/navpages/dicover_old.dart';
import 'package:quotes_list/pages/navpages/main_page.dart';
import 'package:quotes_list/utils/routes/routes.dart';
import 'package:quotes_list/utils/routes/routes_name.dart';
import 'package:quotes_list/view_models/category_viewmodel.dart';
import 'package:quotes_list/widgets/gridview_demo_new.dart';
/// IIIrd  approach
void main() {

   runApp(MaterialApp(
      title: "Flutter Example",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      initialRoute: RoutesName.mainPage,
      onGenerateRoute: Routes.generateRoute,
      // home:MainPage() ,
    ),
  );
}
/// Main Examples  IInd  approach
// void main() {
//   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//   // SystemChrome.setSystemUIOverlayStyle(
//   //   SystemUiOverlayStyle(
//   //     systemNavigationBarColor: Colors.black.withOpacity(0.002),
//   //   ),
//   // );
//   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (_) => CategroyListModel()),
//     ],
//     child: MaterialApp(
//       title: "Flutter Example",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.black,
//       ),
//       initialRoute: RoutesName.mainPage,
//       onGenerateRoute: Routes.generateRoute,
//       // home:MainPage() ,
//     ),
//   ));
// }

/// Ist approach
//  runApp(
//       MaterialApp(
//     title: "Flutter Example",
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//       primaryColor:Colors.black,
//     ),
//     initialRoute: RoutesName.mainPage,
//     onGenerateRoute: Routes.generateRoute,
//    // home:MainPage() ,
//   ));

///Demo Examples
void main1() {
  runApp(MaterialApp(
    title: "Flutter Example",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.black,
    ),
    home: Scaffold(
      body: GridViewApp(),
    ),
  ));
}
