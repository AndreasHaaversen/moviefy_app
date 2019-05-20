// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
      title: json['title'] as String,
      posterURL: json['posterURL'] as String,
      overview: json['overview'] as String,
      voteAverage: json['voteAverage'] as int);
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'title': instance.title,
      'posterURL': instance.posterURL,
      'overview': instance.overview,
      'voteAverage': instance.voteAverage
    };
