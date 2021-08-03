// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDimension _$PokemonDimensionFromJson(Map<String, dynamic> json) {
  return PokemonDimension(
    maximum: json['maximum'] as String,
    minimum: json['minimum'] as String,
  );
}

Map<String, dynamic> _$PokemonDimensionToJson(PokemonDimension instance) =>
    <String, dynamic>{
      'minimum': instance.minimum,
      'maximum': instance.maximum,
    };

PokemonEvolution _$PokemonEvolutionFromJson(Map<String, dynamic> json) {
  return PokemonEvolution(
    name: json['name'] as String,
    amount: json['amount'] as int,
  );
}

Map<String, dynamic> _$PokemonEvolutionToJson(PokemonEvolution instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
    };

PokemonAttack _$PokemonAttackFromJson(Map<String, dynamic> json) {
  return PokemonAttack(
    fast: (json['fast'] as List<dynamic>)
        .map((e) => e == null ? null : Attack.fromJson(e))
        .toList(),
    special: (json['special'] as List<dynamic>)
        .map((e) => e == null ? null : Attack.fromJson(e))
        .toList(),
  );
}

Map<String, dynamic> _$PokemonAttackToJson(PokemonAttack instance) =>
    <String, dynamic>{
      'fast': instance.fast,
      'special': instance.special,
    };

Attack _$AttackFromJson(Map<String, dynamic> json) {
  return Attack(
    name: json['name'] as String?,
    type: json['type'] as String?,
    damage: const StringToIntJsonConverter().fromJson(json['damage']),
  );
}

Map<String, dynamic> _$AttackToJson(Attack instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'damage': const StringToIntJsonConverter().toJson(instance.damage),
    };
