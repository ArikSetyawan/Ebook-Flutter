part of 'favourite_book_bloc.dart';

sealed class FavouriteBookState extends Equatable {
  const FavouriteBookState();
  
  @override
  List<Object> get props => [];
}

final class FavouriteBookInitial extends FavouriteBookState {}

final class FavouriteBookLoading extends FavouriteBookState {}

final class FavouriteBookLoaded extends FavouriteBookState {
  final BookResponse bookResponse;

  const FavouriteBookLoaded({required this.bookResponse});
  @override
  List<Object> get props => [bookResponse];
}

final class FavouriteBookError extends FavouriteBookState {
  final String message;

  const FavouriteBookError({required this.message});
  @override
  List<Object> get props => [message];
}