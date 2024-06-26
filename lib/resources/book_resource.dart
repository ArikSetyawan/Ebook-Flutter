import 'package:dio/dio.dart';

class BookResource {
  final Dio _dio = Dio();

  Future<Response> getListBook(String url) async {
    final Response response = await _dio.get(url);
    return response;
  }
}