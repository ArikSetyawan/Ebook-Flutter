import 'package:bloc/bloc.dart';
import 'package:ebook_flutter/models/book.dart';
import 'package:ebook_flutter/repositories/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'detail_book_event.dart';
part 'detail_book_state.dart';

class DetailBookBloc extends Bloc<DetailBookEvent, DetailBookState> {
  final BookRepository _bookRepository = BookRepository();
  DetailBookBloc() : super(DetailBookInitial()) {
    on<LoadDetailBook>((event, emit) async {
      emit(DetailBookLoading());
      try {
        emit(DetailBookLoaded(book: event.book));
      } catch (e) {
        emit(DetailBookError(message: e.toString()));
      }
    });

    on<AddToFavourite>((event, emit) async {
      try {
        await _bookRepository.addToFavourite(event.book.id);
        Book book = Book.fromJson(event.book.toJson());
        book.favourite = true;
        emit(DetailBookLoaded(book: book));
      } catch (e) {
        emit(DetailBookError(message: e.toString()));
      }
    });

    on<RemoveFromFavourite>((event, emit) async {
      try {
        await _bookRepository.removeFromFavourite(event.book.id);
        Book book = Book.fromJson(event.book.toJson());
        book.favourite = false;
        emit(DetailBookLoaded(book: book));
      } catch (e) {
        emit(DetailBookError(message: e.toString()));
      }
    });
  }
}
