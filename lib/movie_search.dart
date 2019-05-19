import 'package:flutter/material.dart';

import 'moviefy_drawer.dart';

class Search extends StatelessWidget {
  static final String routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text.rich(TextSpan(
            text: '',
            children: <TextSpan>[
              TextSpan(
                  text: 'MOVIE', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'FY'),
            ],
          )),
        ),
        drawer: MoviefyDrawer(),
        body: Center(
          child: Text(
            'Search'
          ),
        ),
    );
  }
}