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
        final BookResponse bookResponse = await _bookRepository.getBooks();
        emit(BookLoaded(bookResponse: bookResponse));
      } catch (e) {
        emit(BookError(message: e.toString()));
      }
    });

    on<LoadMoreBooks>((event, emit) async {
      // emit(BookLoading());
      try {
        BookResponse bookResponse = await _bookRepository.getBooks(event.nextUrl);
        List<Book> books = [...event.books,...bookResponse.books];
        bookResponse.books = books;
        emit(BookLoaded(bookResponse: bookResponse));
      } catch (e) {
        emit(BookError(message: e.toString()));
      }
    });

    on<SearchBook>((event, emit) async {
      emit(BookLoading());
      try {
        final BookResponse bookResponse = await _bookRepository.getBooks(null,event.keyword);
        emit(BookLoaded(bookResponse: bookResponse));
      } catch (e) {
        emit(BookError(message: e.toString()));
      }
    });

    on<AddToFavouriteBook>((event, emit) async {
      try {
        await _bookRepository.addToFavourite(event.book.id);
        
        List<Book> books = event.bookResponse.books;
        int index = books.indexWhere((element) => element.id == event.book.id);
        
        Book book = Book.fromJson(event.book.toJson());
        book.favourite = true;

        books.removeAt(index);
        books.insert(index, book);
        BookResponse bookResponse = BookResponse(books: books, nextUrl: event.bookResponse.nextUrl, previousUrl: event.bookResponse.previousUrl);
        emit(BookLoaded(bookResponse: bookResponse));
      } catch (e) {
        emit(BookError(message: e.toString()));
      }
    });

    on<RemoveFromFavouriteBook>((event, emit) async {
      try {
        await _bookRepository.removeFromFavourite(event.book.id);

        List<Book> books = event.bookResponse.books;
        int index = books.indexWhere((element) => element.id == event.book.id);
        
        Book book = Book.fromJson(event.book.toJson());
        book.favourite = false;

        books.removeAt(index);
        books.insert(index, book);
        BookResponse bookResponse = BookResponse(books: books, nextUrl: event.bookResponse.nextUrl, previousUrl: event.bookResponse.previousUrl);
        emit(BookLoaded(bookResponse: bookResponse));
      } catch (e) {
        emit(BookError(message: e.toString()));
      }
    });
  }
}
