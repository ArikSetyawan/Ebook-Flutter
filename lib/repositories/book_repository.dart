import 'package:dio/dio.dart';
import 'package:ebook_flutter/models/book.dart';
import 'package:ebook_flutter/models/book_response.dart';
import 'package:ebook_flutter/repositories/dio_exception.dart';
import 'package:ebook_flutter/resources/book_resource.dart';

class BookRepository {
  final BookResource _bookResource = BookResource();

  Future<BookResponse> getBooks(String? url) async {
    // try {
      const String initialUrl = "https://gutendex.com/books/";
      final Response response = await _bookResource.getListBook(url ?? initialUrl);
      final dynamic data = response.data;
      final String? nextUrl = data['next'];
      final String? previousUrl = data['previous'];
      List<Book> books = List.generate(data['results'].length,(index) {
          Map<String,dynamic> rawBook = data['results'][index];
          rawBook['favourite'] = false;
          Book book = Book.fromJson(rawBook);
          return book;
        },
      );

      final BookResponse bookResponse = BookResponse(books: books, nextUrl: nextUrl, previousUrl: previousUrl);
      return bookResponse;
    // } on DioException catch (e){
    //   final errorMessage = DioExceptions.fromDioError(e).toString();
    //   throw(errorMessage);
    // }
  }
}