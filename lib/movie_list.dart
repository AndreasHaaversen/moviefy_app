import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:moviefy_app/bloc/movie_bloc.dart';
import 'package:moviefy_app/models/movie_collection.dart';
import 'package:moviefy_app/models/movie.dart';

import 'movie_detail.dart';
import 'moviefy_drawer.dart';
import 'movie_search.dart';

import 'package:moviefy_app/models/movie.dart';

class MovieList extends StatefulWidget {
  final MoviefyBlock block;

  MovieList({Key key, this.block}) : super(key: key);

  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieList> {
  List<Movie> movies;

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
                child: StreamBuilder<List<Movie>>(
                    stream: widget.block.movies,
                    initialData: <Movie>[],
                    builder: (context, snapshot) => ListView(
                          children: snapshot.data.map(_buildItem).toList(),
                        ))
                )],
            )));
  }

  Widget _buildItem(Movie movie) {
    return FlatButton(
      child: MovieCard(movie),
      padding: const EdgeInsets.all(0.0),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MovieDetail(movie);
        }));
      },
    );
  }
}

void _placeHolder() {}

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
  final movie;
  final image_url = 'https://image.tmdb.org/t/p/w500/';

  MovieCard(this.movie);

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
                    image: NetworkImage(image_url + movie.poster_path),
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
                movie.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Padding(padding: const EdgeInsets.all(2.0)),
              Text(
                movie.overview,
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
