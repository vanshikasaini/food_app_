abstract class BaseApiService{

  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url);
  Future<dynamic> getPostApiSampleResponse(String url,dynamic data);

}