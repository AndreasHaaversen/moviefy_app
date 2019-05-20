import 'package:flutter/material.dart';

import 'movie_detail.dart';
import 'moviefy_drawer.dart';
import 'movie_search.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieList> {
  var movies;

  void getData() async {
    var data = await getJSON();

    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
            )
          ],
        ),
        drawer: MoviefyDrawer(),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                MovieTitle(),
                Expanded(
                  child: ListView.builder(
                    itemCount: movies == null ? 0 : movies.length,
                    itemBuilder: (context, i) {
                      return FlatButton(
                        child: MovieCard(movies, i),
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MovieDetail(movies[i]);
                          }));
                        },
                      );
                    },
                  ),
                )
              ],
            )));
  }
}

void _placeHolder() {}

Future<Map> getJSON() async {
  var url =
      'http://api.themoviedb.org/3/discover/movie?api_key=1ead4035163c520c10d30f773c296b20';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class MovieTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: Text(
        'Top Rated',
        style: TextStyle(
          fontSize: 40.0,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final movies;
  final i;
  final image_url = 'https://image.tmdb.org/t/p/w500/';

  MovieCard(this.movies, this.i);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Container(
                width: 250.0,
                height: 250.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey,
                image: DecorationImage(
                    image: NetworkImage(image_url + movies[i]['poster_path']),
                    fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                      color: Colors.green,
                      blurRadius: 5.0,
                      offset: Offset(2.0, 5.0))
                ],
              ),
            ),
          ),
        ],
      ),
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Expanded(
            child: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: Column(
            children: [
              Text(
                movies[i]['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Padding(padding: const EdgeInsets.all(2.0)),
              Text(
                movies[i]['overview'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xff8785A4), fontFamily: 'Arvo'),
              )
            ],
          ),
        )),
      ]),
      Divider(),
    ]);
  }
}
