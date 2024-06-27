import 'package:ebook_flutter/blocs/book/bloc/book_bloc.dart';
import 'package:ebook_flutter/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<BookBloc>().add(LoadBooks());
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final offset = _scrollController.offset;
      if (maxScroll == offset) {
        fetchNextProduct();
      }
    });
  }

  void fetchNextProduct() {
    BookBloc bookState = BlocProvider.of<BookBloc>(context);
    final currentState = bookState.state;
    if (currentState is BookLoaded) {
      if (currentState.bookResponse.nextUrl != null) {
        context.read<BookBloc>().add(LoadMoreBooks(books: currentState.bookResponse.books, nextUrl: currentState.bookResponse.nextUrl!));
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
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search. Ex: Charles Dickens"
                ),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    context.read<BookBloc>().add(SearchBook(keyword: value));
                  } else {
                    context.read<BookBloc>().add(LoadBooks());
                  }
                },
              ),
              const SizedBox(height: 35,),
              BlocBuilder<BookBloc, BookState>(
                builder: (context, state) {
                  if (state is BookInitial) {
                    return const SizedBox.shrink();
                  } else if (state is BookLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BookLoaded) {
                    return Column(
                      children: List.generate(state.bookResponse.books.length, (index) =>  BookCardWidget(book: state.bookResponse.books[index],))..add(state.bookResponse.nextUrl != null ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink() ),
                    );
                  } else if (state is BookError) {
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