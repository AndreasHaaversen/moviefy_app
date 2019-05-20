import 'package:flutter/material.dart';
import 'package:moviefy_app/bloc/movie_bloc.dart';

import 'movie_list.dart';

void main() { 
  final movieBlock = MoviefyBlock();
  runApp(MyApp(block: movieBlock));
}

class MyApp extends StatelessWidget {
  final MoviefyBlock block;

  MyApp({
    Key key,
    this.block,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieFy',
      home: MovieList(block: this.block),
      theme: ThemeData(
        primaryColor: Colors.white,
        buttonColor: Colors.green,
      )
    );
  }
}