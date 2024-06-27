import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_flutter/blocs/book/bloc/book_bloc.dart';
import 'package:ebook_flutter/blocs/detail_book/bloc/detail_book_bloc.dart';
import 'package:ebook_flutter/blocs/favourite_book/bloc/favourite_book_bloc.dart';
import 'package:ebook_flutter/models/book.dart';
import 'package:ebook_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
class BookCardWidget extends StatelessWidget {
  final Book book;
  const BookCardWidget({
    super.key, required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          context.read<DetailBookBloc>().add(LoadDetailBook(book: book));
          context.pushNamed('book');
        },
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  width: 86,
                  placeholder: (context, url) {
                    return const CircularProgressIndicator();
                  },
                  errorWidget: (context, url, error) => Image.asset('assets/images/not-found.png'),
                  imageUrl: book.formats.imageJpeg ?? "",
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 135,
                    child: Text(book.title, style: header16Bold, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 165,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Icon(Icons.person),
                          ),
                          TextSpan(
                            text: book.authors.map((e) => e.name).toList().join(','),
                            style: descriptionText12Regular.copyWith(color: sixthColor),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Builder(
                builder: (context) {
                  if (book.favourite) {
                    return IconButton(
                      onPressed: () {
                        final BookBloc bookBloc = BlocProvider.of<BookBloc>(context);
                        final BookState bookState = bookBloc.state;
                        if (bookState is BookLoaded) {
                          context.read<BookBloc>().add(RemoveFromFavouriteBook(bookResponse: bookState.bookResponse, book: book));
                        }
                        context.read<FavouriteBookBloc>().add(LoadFavouriteBooks());
                      },
                      icon: const Icon(Icons.favorite, color: Colors.redAccent,));
                  } else {
                    return IconButton(
                      onPressed: () {
                        final BookBloc bookBloc = BlocProvider.of<BookBloc>(context);
                        final BookState bookState = bookBloc.state;
                        if (bookState is BookLoaded) {
                          context.read<BookBloc>().add(AddToFavouriteBook(bookResponse: bookState.bookResponse, book: book));
                        }
                        context.read<FavouriteBookBloc>().add(LoadFavouriteBooks());
                      },
                      icon: const Icon(Icons.favorite_outline));
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}