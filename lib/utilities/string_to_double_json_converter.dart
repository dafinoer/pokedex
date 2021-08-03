import 'package:json_annotation/json_annotation.dart';

class StringToDoubleJsonConverter implements JsonConverter<double?, dynamic> {
  const StringToDoubleJsonConverter();

  @override
  double? fromJson(dynamic json) {
    if (json is double) return json;
    if (json != null && json is String && double.tryParse(json) != null) {
      return double.parse(json);
    } else if (json == null) {
      return null;
    } else {
      throw ArgumentError('Invalid string format');
    }
  }

  @override
  String toJson(double? json) => '$json';
}
