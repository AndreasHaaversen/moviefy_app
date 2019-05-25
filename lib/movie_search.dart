import 'package:flutter/material.dart';
import 'package:moviefy_app/bloc/movie_bloc.dart';

import 'models/movie.dart';
import 'movie_detail.dart';

class CustomSearchDelegate extends SearchDelegate<Movie> {
  var movies;
  MoviefyBlock block;

  CustomSearchDelegate(this.block);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    block.searchTerm.add(query);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: StreamBuilder<List<Movie>>(
                  stream: block.moviesResult,
                  initialData: <Movie>[],
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(child: CircularProgressIndicator()),
                        ],
                      );
                    } else if (snapshot.data.length == 0) {
                      return Column(
                        children: <Widget>[
                          Center(
                              child: Text(
                            "No Results Found.",
                          )),
                        ],
                      );
                    } else {
                      return ListView(
                          children: snapshot.data.map((movie) {
                           return _buildItem(context, movie);
                          }).toList());
                    }
                  }))
        ]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }

  Widget _buildItem(BuildContext context, Movie movie) {
    return Card(
      child: FlatButton(
        child: MovieSearchCard(movie),
        padding: const EdgeInsets.all(0.0),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MovieDetail(movie);
          })
          );
        },
      ),
    );
  }
}

class MovieSearchCard extends StatelessWidget {
  final Movie movie;
  final image_url = 'https://image.tmdb.org/t/p/w500/';

  MovieSearchCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            margin: EdgeInsets.all(16.0),
            child: Container(
              width: 100.0,
              height: 100.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey,
              image: DecorationImage(
                  image: movie.poster_path!= null ? NetworkImage( image_url + movie.poster_path) : AssetImage('assets/image.png'),
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
        Expanded(
            child: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: Column(
            children: [
              Text(
                movie.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Padding(padding: const EdgeInsets.all(2.0)),
              Text(
                movie.overview,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        )),
      ]),
      Divider(),
    ]);
  }
}
