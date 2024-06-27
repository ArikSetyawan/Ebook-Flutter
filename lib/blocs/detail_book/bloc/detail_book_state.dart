part of 'detail_book_bloc.dart';

sealed class DetailBookState extends Equatable {
  const DetailBookState();
  
  @override
  List<Object> get props => [];
}

final class DetailBookInitial extends DetailBookState {}

final class DetailBookLoading extends DetailBookState {}

final class DetailBookLoaded extends DetailBookState {
  final Book book;

  const DetailBookLoaded({required this.book});

  @override
  List<Object> get props => [book];
}

final class DetailBookError extends DetailBookState {
  final String message;

  const DetailBookError({required this.message});

  @override
  List<Object> get props => [message];
}