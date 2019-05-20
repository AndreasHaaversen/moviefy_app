library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:moviefy_app/models/movie_collection.dart';
import 'movie.dart';
import 'movie_collection.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Movie,
  MovieCollection,
])

Serializers serializers = _$serializers;

final Serializers standardSerializers =
(serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();