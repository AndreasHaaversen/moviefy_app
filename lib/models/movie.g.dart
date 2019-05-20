// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
      title: json['title'] as String,
      poster_path: json['poster_path'] as String,
      overview: json['overview'] as String,
      vote_average: (json['vote_average'] as num)?.toDouble());
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'title': instance.title,
      'poster_path': instance.poster_path,
      'overview': instance.overview,
      'vote_average': instance.vote_average
    };
