import 'package:bloc/bloc.dart';
import 'package:ebook_flutter/models/book.dart';
import 'package:ebook_flutter/models/book_response.dart';
import 'package:ebook_flutter/repositories/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository _bookRepository = BookRepository();
  BookBloc() : super(BookInitial()) {
    on<LoadBooks>((event, emit) async {
      emit(BookLoading());
      try {
        final BookResponse bookResponse = await _bookRepository.getBooks(null);
        emit(BookLoaded(books: bookResponse.books));
      } catch (e) {
        emit(BookError(message: e.toString()));
      }
    });
  }
}
