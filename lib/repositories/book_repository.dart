import 'package:dio/dio.dart';
import 'package:ebook_flutter/models/book.dart';
import 'package:ebook_flutter/models/book_response.dart';
import 'package:ebook_flutter/repositories/dio_exception.dart';
import 'package:ebook_flutter/resources/book_resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookRepository {
  final BookResource _bookResource = BookResource();

  Future<BookResponse> getBooks([String? url, String? keyword]) async {
    try {
      const String initialUrl = "https://gutendex.com/books/";
      final Response response = await _bookResource.getListBook(url ?? initialUrl, keyword, null);
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

      for (int i = 0; i < books.length; i++) {
        final bool isFavourite = await isBookFavourite(books[i].id);
        books[i].favourite = isFavourite;
      }

      final BookResponse bookResponse = BookResponse(books: books, nextUrl: nextUrl, previousUrl: previousUrl);
      return bookResponse;
    } on DioException catch (e){
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw(errorMessage);
    }
  }

  Future<bool> isBookFavourite(int bookId) async {
    bool isFavourite = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? favouriteBooks = prefs.getStringList('favourites');
    if (favouriteBooks != null) {
      List<int> bookIds = favouriteBooks.map((i) => int.parse(i)).toList();
      if (bookIds.contains(bookId)) {
        isFavourite = true;
      }
    }

    return isFavourite;
  }

  Future<void> addToFavourite(int bookId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? favouriteBooks = prefs.getStringList('favourites');
    if (favouriteBooks != null) {
      List<int> bookIds = favouriteBooks.map((i) => int.parse(i)).toList();
      if (!bookIds.contains(bookId)) {
        bookIds.insert(0, bookId);
        List<String> bookIdsStr = bookIds.map((i)=>i.toString()).toList();
        await prefs.setStringList('favourites', bookIdsStr);
      }
      return;
    } else {
      List<String> bookIds = [bookId.toString()];
      await prefs.setStringList('favourites', bookIds);
      return;
    }
  }

  Future<void> removeFromFavourite(int bookId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? favouriteBooks = prefs.getStringList('favourites');
    if (favouriteBooks != null) {
      List<int> bookIds = favouriteBooks.map((i) => int.parse(i)).toList();
      if (bookIds.contains(bookId)) {
        bookIds.remove(bookId);
        List<String> bookIdsStr = bookIds.map((i)=>i.toString()).toList();
        await prefs.setStringList('favourites', bookIdsStr);
      }
      return;
    }
  }

  Future<BookResponse> getFavouriteBooks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? favouriteBooks = prefs.getStringList('favourites');
    if (favouriteBooks != null) {
      if (favouriteBooks.isNotEmpty) {
        String ids = favouriteBooks.join(',');
        const String initialUrl = "https://gutendex.com/books/";
        final Response response = await _bookResource.getListBook(initialUrl, null, ids);
        final dynamic data = response.data;
        final String? nextUrl = data['next'];
        final String? previousUrl = data['previous'];
        List<Book> books = List.generate(data['results'].length,(index) {
            Map<String,dynamic> rawBook = data['results'][index];
            rawBook['favourite'] = true;
            Book book = Book.fromJson(rawBook);
            return book;
          },
        );

        for (int i = 0; i < books.length; i++) {
          final bool isFavourite = await isBookFavourite(books[i].id);
          books[i].favourite = isFavourite;
        }

        final BookResponse bookResponse = BookResponse(books: books, nextUrl: nextUrl, previousUrl: previousUrl);
        return bookResponse;
      } else {
        return BookResponse(books: [], nextUrl: null, previousUrl: null);
      }
    }
    return BookResponse(books: [], nextUrl: null, previousUrl: null);
  }
}