import 'package:json_annotation/json_annotation.dart';

class StringToIntJsonConverter implements JsonConverter<int?, dynamic> {
  const StringToIntJsonConverter();

  @override
  int? fromJson(dynamic json) {
    if (json is int) return json;
    if (json != null && json is String) {
      return int.parse(json);
    } else if (json == null) {
      return null;
    } else {
      throw ArgumentError('Invalid string format');
    }
  }

  @override
  String toJson(int? json) => '$json';
}
