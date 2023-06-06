import '../data/network/baseapiservices.dart';
import '../data/network/networkapiservices.dart';
import '../models/categorieslist.dart';
import '../models/demodart.dart';
import '../models/details.dart';
import '../resources/appurls.dart';

class CategoriesRepository{
  BaseApiService _apiService = NetworkApiService();

  Future<Categories> getCategoriesList() async {
    try {
      dynamic response =
      await _apiService.getGetApiResponse(AppUrl.categoryUrl);
      return response = Categories.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<SpecificCateList> getSpecificDrinkList(dynamic data) async {
    try {
      dynamic response =
      await _apiService.getGetApiResponse(AppUrl.listUrl+data);
      return response = SpecificCateList.fromJson(response);
      //await _apiService.getPostApiResponse(AppUrl.listUrl+data);
     // return response;
    } catch (e) {
      throw e;
    }
  }
  Future<Details> getSDrinkDetailList(dynamic data) async {
    try {
      dynamic response =
      await _apiService.getGetApiResponse(AppUrl.detailUrl+data);
      return response = Details.fromJson(response);
      //await _apiService.getPostApiResponse(AppUrl.listUrl+data);
     // return response;
    } catch (e) {
      throw e;
    }
  }
}