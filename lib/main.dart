import 'package:flutter/material.dart';

import 'movie_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'MovieFy',
      home: MovieList(),
      theme: ThemeData(
        primaryColor: Colors.white,
        buttonColor: Colors.green,
      )
    );
  }
}