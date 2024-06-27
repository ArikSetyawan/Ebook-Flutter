part of 'favourite_book_bloc.dart';

sealed class FavouriteBookEvent extends Equatable {
  const FavouriteBookEvent();

  @override
  List<Object> get props => [];
}

class LoadFavouriteBooks extends FavouriteBookEvent {}

class LoadMoreFavouriteBooks extends FavouriteBookEvent {
  final String nextUrl;
  final List<Book> books;

  const LoadMoreFavouriteBooks({required this.nextUrl, required this.books});

  @override
  List<Object> get props => [nextUrl];
}