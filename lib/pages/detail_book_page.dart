import 'package:flutter/material.dart';
import 'package:ebook_flutter/theme.dart';
 
class DetailBookPage extends StatefulWidget {
  final int bookId;
  const DetailBookPage({super.key, required this.bookId});
 
  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}
 
class _DetailBookPageState extends State<DetailBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text("Detail Book"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 334
                  ),
                  child: Image.network('https://www.gutenberg.org/cache/epub/2542/pg2542.cover.medium.jpg'),
                ),
              ),
              const SizedBox(height: 24,),
              Row(
                children: [
                  const SizedBox(
                    width: 171,
                    child: Text("A Doll's House : a play", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  ),
                  const Spacer(),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_outline))
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
                      style: descriptionText14Regular.copyWith(color: sixthColor)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}