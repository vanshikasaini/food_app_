import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:quotes_list/data/response/api_response.dart';
import 'package:quotes_list/models/demodart.dart';
import 'package:quotes_list/repositories/categories_list.dart';
import '../models/categorieslist.dart';
import '../models/details.dart';

class CategroyListModel with ChangeNotifier {
  final _appRepo = CategoriesRepository();

  //final _appRepo = AuthRepository();
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// List of Category
  ApiResponse<Categories> categoriesList = ApiResponse.loading();

  setCategoriesList(ApiResponse<Categories> response) {
    categoriesList = response;
    notifyListeners();
  }

  Future<void> fetchCategoriesListApi() async {
    setCategoriesList(ApiResponse.loading());
    _appRepo.getCategoriesList().then((value) {
      setCategoriesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCategoriesList(ApiResponse.error(error.toString()));
    });
  }

  /// Specific Category Drink List

  ApiResponse<SpecificCateList> specificCateListObj = ApiResponse.loading();

  setSpecificCategoryDrinkList(ApiResponse<SpecificCateList> response) {
    specificCateListObj = response;
    notifyListeners();
  }

  Future<void> fetchSpecificCategoryDrinkListApi(dynamic data) async {
    debugPrint("=======value data==========${data.toString()}");
    setSpecificCategoryDrinkList(ApiResponse.loading());
    _appRepo.getSpecificDrinkList(data).then((value) {
      debugPrint("=================${value.toString()}");
      setSpecificCategoryDrinkList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      debugPrint("=========error========${error.toString()}");
      setSpecificCategoryDrinkList(ApiResponse.error(error.toString()));
    });
  }

  /// Detail screen by drink id

  ApiResponse<Details> drinkDetailObj = ApiResponse.loading();

  setDrinkDetail(ApiResponse<Details> response) {
    drinkDetailObj = response;
    notifyListeners();
  }

  Future<void> fetchDrinkDetailApi(dynamic data) async {
    debugPrint("=======value data==========${data.toString()}");
    setDrinkDetail(ApiResponse.loading());
    _appRepo.getSDrinkDetailList(data).then((value) {
      debugPrint("=================${value.toString()}");
      setDrinkDetail(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      debugPrint("=========error========${error.toString()}");
      setDrinkDetail(ApiResponse.error(error.toString()));
    });
  }



// Future<void> getCategoryList(BuildContext context) async {
//
//
//   setLoading(true);
//
//   _appRepo.getSpecificList(data).then((value) {
//     setLoading(false);
//
//     if (kDebugMode) {
//       print(value.toString());
//     }
//     categories=value as Categories;
//
//   }).onError((error, stackTrace) {
//     if (kDebugMode) {
//       print(error.toString());
//     }
//
//   });
//
//
// }
}
