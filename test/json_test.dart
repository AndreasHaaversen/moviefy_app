import 'package:flutter_test/flutter_test.dart';
import 'package:moviefy_app/models/movie.dart';
import 'package:moviefy_app/models/movie_collection.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  test("Parse movie.json", () {
    const jsonString = """{
  "adult": false,
  "backdrop_path": "/fupyzBwFAn1PoeCXhp54bYVM2ER.jpg",
  "belongs_to_collection": null,
  "budget": 10000000,
  "genres": [
    {
      "id": 80,
      "name": "Crime"
    },
    {
      "id": 53,
      "name": "Thriller"
    }
  ],
  "homepage": null,
  "id": 500,
  "imdb_id": "tt0105236",
  "original_language": "en",
  "original_title": "Reservoir Dogs",
  "overview": "A botched robbery indicates a police informant, and the pressure mounts in the aftermath at a warehouse. Crime begets violence as the survivors -- veteran Mr. White, newcomer Mr. Orange, psychopathic parolee Mr. Blonde, bickering weasel Mr. Pink and Nice Guy Eddie -- unravel.",
  "popularity": 22.648,
  "poster_path": "/jX94vnfcuJ8rTnFbsoriY6dlHrC.jpg",
  "production_companies": [
    {
      "id": 285,
      "logo_path": null,
      "name": "Live Entertainment",
      "origin_country": ""
    },
    {
      "id": 26198,
      "logo_path": null,
      "name": "Dog Eat Dog Productions",
      "origin_country": ""
    }
  ],
  "production_countries": [
    {
      "iso_3166_1": "US",
      "name": "United States of America"
    }
  ],
  "release_date": "1992-09-02",
  "revenue": 0,
  "runtime": 99,
  "spoken_languages": [
    {
      "iso_639_1": "en",
      "name": "English"
    }
  ],
  "status": "Released",
  "tagline": "Every dog has his day.",
  "title": "Reservoir Dogs",
  "video": false,
  "vote_average": 8.1,
  "vote_count": 7049
}""";
    Map movieMap = json.decode(jsonString);
    expect(Movie.fromJson(movieMap).title, "Reservoir Dogs");
  });

  test("Get network data", () async {
    var url =
        "https://api.themoviedb.org/3/discover/movie?api_key=1ead4035163c520c10d30f773c296b20&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var resultsJson = json.decode(response.body);
      expect(
          MovieCollection.fromJson(resultsJson).results[0].title, "John Wick: Chapter 3 – Parabellum");
    }
  });
}
