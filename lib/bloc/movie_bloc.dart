import 'package:moviefy_app/models/movie.dart';
import 'package:moviefy_app/models/movie_collection.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class MoviefyBlock {
  var _movies = <Movie>[];

  var _moviesResult = <Movie>[];

  Stream<List<Movie>> get movies => _moviesSubject.stream;
  final _moviesSubject = BehaviorSubject<List<Movie>>();

  Sink<String> get searchTerm => _searchTermController.sink;
  final _searchTermController = StreamController<String>();

  Stream<List<Movie>> get moviesResult => _moviesResultSubject.stream;
  final _moviesResultSubject = BehaviorSubject<List<Movie>>();

  MoviefyBlock() {
    _updateMovies().then((_) {
      _moviesSubject.add(_movies);
    });

    _searchTermController.stream.listen((query) {
      _searchMovies(query).then((_) {
        _moviesResultSubject.add(_moviesResult);
      });
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

  Future<Null> _searchMovies(String query) async {
    if (query.length > 2) {
      var url =
          "https://api.themoviedb.org/3/search/movie?api_key=1ead4035163c520c10d30f773c296b20&language=en-US&page=1&include_adult=false&query=" +
              query;
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body);
        _moviesResult = MovieCollection.fromJson(resultsJson).results;
      }
    }
  }

  dispose() {
    _searchTermController.close();
  }
}
