import 'package:bloc/bloc.dart';
import 'package:ebook_flutter/models/book.dart';
import 'package:ebook_flutter/models/book_response.dart';
import 'package:ebook_flutter/repositories/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'favourite_book_event.dart';
part 'favourite_book_state.dart';

class FavouriteBookBloc extends Bloc<FavouriteBookEvent, FavouriteBookState> {
  final BookRepository _bookRepository = BookRepository();
  FavouriteBookBloc() : super(FavouriteBookInitial()) {
    on<LoadFavouriteBooks>((event, emit) async {
      emit(FavouriteBookLoading());
      try {
        final BookResponse bookResponse = await _bookRepository.getFavouriteBooks();
        emit(FavouriteBookLoaded(bookResponse: bookResponse));
      } catch (e) {
        emit(FavouriteBookError(message: e.toString()));
      }
    });

    on<LoadMoreFavouriteBooks>((event, emit) async {
      // emit(BookLoading());
      try {
        BookResponse bookResponse = await _bookRepository.getBooks(event.nextUrl);
        List<Book> books = [...event.books,...bookResponse.books];
        bookResponse.books = books;
        emit(FavouriteBookLoaded(bookResponse: bookResponse));
      } catch (e) {
        emit(FavouriteBookError(message: e.toString()));
      }
    });
  }
}
