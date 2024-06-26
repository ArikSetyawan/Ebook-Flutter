import 'package:ebook_flutter/widgets/book_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              Column(
                children: List.generate(32, (index) => const BookCardWidget()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}