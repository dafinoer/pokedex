import 'package:Pokemon/utilities/string_to_double_json_converter.dart';
import 'package:Pokemon/utilities/string_to_int_json_converter.dart';
import 'package:Pokemon/models/additional_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon {
  final String id;
  final String image;
  final String name;
  final String? classification;
  @StringToDoubleJsonConverter()
  final double? fleeRate;
  @StringToIntJsonConverter()
  final int? number;
  @StringToIntJsonConverter()
  final int? maxCP;
  @StringToIntJsonConverter()
  final int? maxHP;
  final PokemonDimension? weight;
  final PokemonDimension? height;
  final PokemonAttack? attacks;
  final PokemonEvolution? evolutionRequirements;
  final List<String>? types;
  final List<String>? resistant;
  final List<String>? weaknesses;
  final List<Pokemon>? evolutions;

  const Pokemon(
      {required this.id,
      required this.image,
      required this.name,
      this.number,
      this.weight,
      this.height,
      this.classification,
      this.types,
      this.resistant,
      this.attacks,
      this.weaknesses,
      this.fleeRate,
      this.maxCP,
      this.maxHP,
      this.evolutions,
      this.evolutionRequirements});

  factory Pokemon.fromJson(dynamic json) => _$PokemonFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}
