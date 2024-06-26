import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class BookCardWidget extends StatelessWidget {
  const BookCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          context.pushNamed('book', queryParameters: {'book_id':"123"});
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
                  placeholder: (context, url) {
                    return const CircularProgressIndicator();
                  },
                  imageUrl: "https://www.gutenberg.org/cache/epub/2542/pg2542.cover.medium.jpg",
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 125,
                    child: Text("A Doll's House : a play", style: header16Bold),
                  ),
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(Icons.person),
                        ),
                        TextSpan(
                          text: " Ibsen, Henrik",
                          style: descriptionText12Regular.copyWith(color: sixthColor)
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
              IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border))
            ],
          ),
        ),
      ),
    );
  }
}