import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'movie.dart';

part 'movie_collection.g.dart';

@JsonSerializable()
class MovieCollection {
  final int page;
  final List<Movie> results;
  final int total_results;
  final int total_pages;

  const MovieCollection ({
      this.page,
      this.results,
      this.total_results,
      this.total_pages,
  });

    factory MovieCollection.fromJson(Map<String, dynamic> json) => _$MovieCollectionFromJson(json);

      Map<String, dynamic> toJson() => _$MovieCollectionToJson(this);
}