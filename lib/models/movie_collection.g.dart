// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCollection _$MovieCollectionFromJson(Map<String, dynamic> json) {
  return MovieCollection(
      page: json['page'] as int,
      results: (json['results'] as List)
          ?.map((e) =>
              e == null ? null : Movie.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      total_results: json['total_results'] as int,
      total_pages: json['total_pages'] as int);
}

Map<String, dynamic> _$MovieCollectionToJson(MovieCollection instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_results': instance.total_results,
      'total_pages': instance.total_pages
    };
