part of 'detail_book_bloc.dart';

sealed class DetailBookEvent extends Equatable {
  const DetailBookEvent();

  @override
  List<Object> get props => [];
}

class LoadDetailBook extends DetailBookEvent {
  final Book book;

  const LoadDetailBook({required this.book});
  @override
  List<Object> get props => [book];
}

class AddToFavourite extends DetailBookEvent {
  final Book book;

  const AddToFavourite({required this.book});
  @override
  List<Object> get props => [book];
}

class RemoveFromFavourite extends DetailBookEvent {
  final Book book;

  const RemoveFromFavourite({required this.book});
  @override
  List<Object> get props => [book];
}