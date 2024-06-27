part of 'book_bloc.dart';

sealed class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class LoadBooks extends BookEvent {}

class LoadMoreBooks extends BookEvent {
  final String nextUrl;
  final List<Book> books;

  const LoadMoreBooks({required this.nextUrl, required this.books});

  @override
  List<Object> get props => [nextUrl];
}

class SearchBook extends BookEvent {
  final String keyword;

  const SearchBook({required this.keyword});
  
  @override
  List<Object> get props => [keyword];
}

class AddToFavouriteBook extends BookEvent {
  final BookResponse bookResponse;
  final Book book;

  const AddToFavouriteBook({required this.bookResponse, required this.book});
  @override
  List<Object> get props => [bookResponse, book];
}

class RemoveFromFavouriteBook extends BookEvent {
  final BookResponse bookResponse;
  final Book book;

  const RemoveFromFavouriteBook({required this.bookResponse, required this.book});
  @override
  List<Object> get props => [bookResponse, book];
}