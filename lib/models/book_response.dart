

import 'package:ebook_flutter/models/book.dart';

class BookResponse {
  String? nextUrl;
  String? previousUrl;
  List<Book> books;

  BookResponse({
    this.nextUrl,
    this.previousUrl,
    required this.books
  }); 
}