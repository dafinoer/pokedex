// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return Pokemon(
    id: json['id'] as String,
    image: json['image'] as String,
    name: json['name'] as String,
    number: const StringToIntJsonConverter().fromJson(json['number']),
    weight: json['weight'] == null
        ? null
        : PokemonDimension.fromJson(json['weight']),
    height: json['height'] == null
        ? null
        : PokemonDimension.fromJson(json['height']),
    classification: json['classification'] as String?,
    types: (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    resistant:
        (json['resistant'] as List<dynamic>?)?.map((e) => e as String).toList(),
    attacks: json['attacks'] == null
        ? null
        : PokemonAttack.fromJson(json['attacks']),
    weaknesses: (json['weaknesses'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    fleeRate: const StringToDoubleJsonConverter().fromJson(json['fleeRate']),
    maxCP: const StringToIntJsonConverter().fromJson(json['maxCP']),
    maxHP: const StringToIntJsonConverter().fromJson(json['maxHP']),
    evolutions: (json['evolutions'] as List<dynamic>?)
        ?.map((e) => Pokemon.fromJson(e))
        .toList(),
    evolutionRequirements: json['evolutionRequirements'] == null
        ? null
        : PokemonEvolution.fromJson(json['evolutionRequirements']),
  );
}

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'classification': instance.classification,
      'fleeRate': const StringToDoubleJsonConverter().toJson(instance.fleeRate),
      'number': const StringToIntJsonConverter().toJson(instance.number),
      'maxCP': const StringToIntJsonConverter().toJson(instance.maxCP),
      'maxHP': const StringToIntJsonConverter().toJson(instance.maxHP),
      'weight': instance.weight,
      'height': instance.height,
      'attacks': instance.attacks,
      'evolutionRequirements': instance.evolutionRequirements,
      'types': instance.types,
      'resistant': instance.resistant,
      'weaknesses': instance.weaknesses,
      'evolutions': instance.evolutions,
    };
