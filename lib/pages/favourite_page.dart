import 'package:ebook_flutter/blocs/favourite_book/bloc/favourite_book_bloc.dart';
import 'package:ebook_flutter/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<FavouriteBookBloc>().add(LoadFavouriteBooks());
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final offset = _scrollController.offset;
      if (maxScroll == offset) {
        fetchNextProduct();
      }
    });
  }

  void fetchNextProduct() {
    FavouriteBookBloc bookState = BlocProvider.of<FavouriteBookBloc>(context);
    final currentState = bookState.state;
    if (currentState is FavouriteBookLoaded) {
      if (currentState.bookResponse.nextUrl != null) {
        context.read<FavouriteBookBloc>().add(LoadMoreFavouriteBooks(books: currentState.bookResponse.books, nextUrl: currentState.bookResponse.nextUrl!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text("E-Book"),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 25),
              BlocBuilder<FavouriteBookBloc, FavouriteBookState>(
                builder: (context, state) {
                  if (state is FavouriteBookInitial) {
                    return const SizedBox.shrink();
                  } else if (state is FavouriteBookLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FavouriteBookLoaded) {
                    if (state.bookResponse.books.isEmpty) {
                      return const Center(child: Text("Favourite Book Empty."));
                    } else {
                      return Column(
                        children: List.generate(state.bookResponse.books.length, (index) =>  BookCardWidget(book: state.bookResponse.books[index],))..add(state.bookResponse.nextUrl != null ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink() ),
                      );
                    }
                  } else if (state is FavouriteBookError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const  Center(child: Text("Unhandled State"));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}