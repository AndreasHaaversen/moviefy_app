import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final String title;
  final String poster_path;
  final String overview;
  final double vote_average;

  const Movie ({
      this.title,
      this.poster_path,
      this.overview,
      this.vote_average,
  });

    factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

      Map<String, dynamic> toJson() => _$MovieToJson(this);
}