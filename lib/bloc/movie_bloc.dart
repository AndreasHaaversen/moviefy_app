import 'package:moviefy_app/models/movie.dart';
import 'package:moviefy_app/models/movie_collection.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class MoviefyBlock {

  final _moviesSubject = BehaviorSubject<List<Movie>>();

  var _movies = <Movie>[];

  Stream<List<Movie>> get movies => _moviesSubject.stream;

  MoviefyBlock() {
    _updateMovies().then((_) {
      _moviesSubject.add(_movies);
    });
  }

  Future<Null> _updateMovies() async {
      var url =
          'http://api.themoviedb.org/3/discover/movie?api_key=1ead4035163c520c10d30f773c296b20';
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body);
        _movies = MovieCollection.fromJson(resultsJson).results;
      }
  }
}
