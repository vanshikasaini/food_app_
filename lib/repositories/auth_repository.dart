import 'package:quotes_list/data/network/baseapiservices.dart';
import 'package:quotes_list/data/network/networkapiservices.dart';
import 'package:quotes_list/view_models/category_viewmodel.dart';

import '../models/categorieslist.dart';
import '../resources/appurls.dart';

class AuthRepository {
  BaseApiService _apiService = NetworkApiService();

  Future<dynamic> getSpecificList(dynamic data) async {
    try {
      dynamic response =
          await _apiService.getPostApiSampleResponse(AppUrl.listUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
