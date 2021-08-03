import 'package:json_annotation/json_annotation.dart';
import 'package:Pokemon/utilities/string_to_int_json_converter.dart';

part 'additional_data.g.dart';

@JsonSerializable()
class PokemonDimension {
  final String minimum;
  final String maximum;

  const PokemonDimension({required this.maximum, required this.minimum});

  factory PokemonDimension.fromJson(dynamic json) =>
      _$PokemonDimensionFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDimensionToJson(this);
}

@JsonSerializable()
class PokemonEvolution {
  final String name;
  @StringToIntJsonConverter()
  final int amount;

  PokemonEvolution(
      {required this.name, required this.amount});

  factory PokemonEvolution.fromJson(dynamic json) =>
      _$PokemonEvolutionFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonEvolutionToJson(this);
}

@JsonSerializable()
class PokemonAttack {
  final List<Attack?> fast;
  final List<Attack?> special;

  PokemonAttack({required this.fast, required this.special});

  factory PokemonAttack.fromJson(dynamic json) => _$PokemonAttackFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonAttackToJson(this);
}

@JsonSerializable()
class Attack {
  final String? name;
  final String? type;
  @StringToIntJsonConverter()
  final int? damage;

  Attack(
      {required this.name,
      required this.type,
      required this.damage});

  factory Attack.fromJson(dynamic json) => _$AttackFromJson(json);

  Map<String, dynamic> toJson() => _$AttackToJson(this);
}
