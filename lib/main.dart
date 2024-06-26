import 'package:ebook_flutter/app_navigation.dart';
import 'package:ebook_flutter/blocs/book/bloc/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter EBook',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        routerConfig: AppNavigation.router,
      ),
    );
  }
}
