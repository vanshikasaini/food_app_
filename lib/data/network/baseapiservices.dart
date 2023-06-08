abstract class BaseApiService{

  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getGetApiResponse_(String url);
  Future<dynamic> getPostApiSampleResponse(String url,dynamic data);

}