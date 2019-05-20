import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final String title;
  final String posterURL;
  final String overview;
  final int voteAverage;

  const Movie ({
      this.title,
      this.posterURL,
      this.overview,
      this.voteAverage,
  });

    factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

      Map<String, dynamic> toJson() => _$MovieToJson(this);
}