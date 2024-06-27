import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_flutter/blocs/book/bloc/book_bloc.dart';
import 'package:ebook_flutter/blocs/detail_book/bloc/detail_book_bloc.dart';
import 'package:ebook_flutter/blocs/favourite_book/bloc/favourite_book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ebook_flutter/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({super.key});

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Detail Book"),
      ),
      body: BlocBuilder<DetailBookBloc, DetailBookState>(
        builder: (context, state) {
          if (state is DetailBookInitial) {
            return const SizedBox.shrink();
          } else if (state is DetailBookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailBookLoaded) {

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 334),
                        child: CachedNetworkImage(
                          placeholder: (context, url) {
                            return const CircularProgressIndicator();
                          },
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/not-found.png'),
                          imageUrl: state.book.formats.imageJpeg ?? "",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(state.book.title, style: header16Bold),
                        ),
                        const Spacer(),
                        Builder(
                          builder: (context) {
                            if (state.book.favourite) {
                              return IconButton(
                                onPressed: () {
                                  context.read<DetailBookBloc>().add(RemoveFromFavourite(book: state.book));
                                  final BookBloc bookBloc = BlocProvider.of<BookBloc>(context);
                                  final BookState bookState = bookBloc.state;
                                  if (bookState is BookLoaded) {
                                    context.read<BookBloc>().add(RemoveFromFavouriteBook(bookResponse: bookState.bookResponse, book: state.book));
                                  }
                                  context.read<FavouriteBookBloc>().add(LoadFavouriteBooks());
                                },
                                icon: const Icon(Icons.favorite, color: Colors.redAccent,));
                            } else {
                              return IconButton(
                                onPressed: () {
                                  context.read<DetailBookBloc>().add(AddToFavourite(book: state.book));
                                  final BookBloc bookBloc = BlocProvider.of<BookBloc>(context);
                                  final BookState bookState = bookBloc.state;
                                  if (bookState is BookLoaded) {
                                    context.read<BookBloc>().add(AddToFavouriteBook(bookResponse: bookState.bookResponse, book: state.book));
                                  }
                                  context.read<FavouriteBookBloc>().add(LoadFavouriteBooks());
                                },
                                icon: const Icon(Icons.favorite_outline));
                            }
                          }
                        )
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Icon(Icons.person),
                          ),
                          TextSpan(
                              text: " Ibsen, Henrik",
                              style: descriptionText14Regular.copyWith(
                                  color: sixthColor)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is DetailBookError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("Unhandled State"));
          }
        },
      ),
    );
  }
}
