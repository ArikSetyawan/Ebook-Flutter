import 'package:dio/dio.dart';

class BookResource {
  final Dio _dio = Dio();

  Future<Response> getListBook(String url, String? searchKeyword, String? ids) async {
    Map<String,dynamic> params = {};
    if (searchKeyword != null) {
      params["search"] = searchKeyword;
    }
    if (ids != null) {
      params["ids"] = ids;
    }
    final Response response = await _dio.get(url, queryParameters: params);
    return response;
  }
}