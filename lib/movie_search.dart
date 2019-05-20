import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'movie_detail.dart';

class CustomSearchDelegate extends SearchDelegate {
  var movies;

  void getData(String query) async {
    var data = await getJSON(query);
    movies = data['results'];
  }

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
    getData(query);

    if (movies == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "There were no results for \"" + query + "\"",
            ),
          )
        ],
      );
    } else {
      return Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: movies == null ? 0 : movies.length,
            itemBuilder: (context, i) {
              return FlatButton(
                child: MovieSearchCard(movies, i),
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MovieDetail(movies[i]);
                  }));
                },
              );
            },
          ),
        )
      ]);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}

class MovieSearchCard extends StatelessWidget {
  final movies;
  final i;
  final image_url = 'https://image.tmdb.org/t/p/w500/';

  MovieSearchCard(this.movies, this.i);

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
        Expanded(
            child: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: Column(
            children: [
              Text(
                movies[i]['title'],
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Padding(padding: const EdgeInsets.all(2.0)),
              Text(
                movies[i]['overview'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.grey),
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

Future<Map> getJSON(String query) async {
  var url =
      'http://api.themoviedb.org/3/search/movie?api_key=1ead4035163c520c10d30f773c296b20' +
          "&query=\"" +
          query +
          "\"";
  Response response = await get(url);
  return json.decode(response.body);
}
