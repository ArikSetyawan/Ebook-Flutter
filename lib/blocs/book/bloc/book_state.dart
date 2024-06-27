part of 'book_bloc.dart';

sealed class BookState extends Equatable {
  const BookState();
  
  @override
  List<Object> get props => [];
}

final class BookInitial extends BookState {}

final class BookLoading extends BookState {}

final class BookLoaded extends BookState{
  final BookResponse bookResponse;

  const BookLoaded({required this.bookResponse});

  @override
  List<Object> get props => [bookResponse];

}

final class BookError extends BookState {
  final String message;

  const BookError({required this.message});
  
  @override
  List<Object> get props => [message];
} 
