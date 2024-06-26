import 'package:ebook_flutter/blocs/book/bloc/book_bloc.dart';
import 'package:ebook_flutter/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              ),
              const SizedBox(height: 35,),
              ElevatedButton(
                onPressed: (){
                  context.read<BookBloc>().add(LoadBooks());
                }, 
                child: const Text("GetBooks")
              ),
              BlocBuilder<BookBloc, BookState>(
                builder: (context, state) {
                  if (state is BookInitial || state is BookLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BookLoaded) {
                    return Column(
                      children: List.generate(32, (index) => const BookCardWidget()),
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