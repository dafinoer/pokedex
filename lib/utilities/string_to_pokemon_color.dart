import 'dart:ui';

import 'package:Pokemon/assets/pokemon_color.dart';
import 'package:flutter/material.dart';

Color stringToPokemonColor(String string) {
  if (string == 'Flying') {
    return PokemonColors.Flying;
  } else if (string == 'Grass') {
    return PokemonColors.Grass;
  } else if (string == 'Electric') {
    return PokemonColors.Electric;
  } else if (string == 'Fighting') {
    return PokemonColors.Fighting;
  } else if (string == 'Fire') {
    return PokemonColors.Fire;
  } else if (string == 'Ground') {
    return PokemonColors.Ground;
  } else if (string == 'Normal') {
    return PokemonColors.Normal;
  } else if (string == 'Physic') {
    return PokemonColors.Physic;
  } else if (string == 'Poison') {
    return PokemonColors.Poison;
  } else if (string == 'Rock') {
    return PokemonColors.Rock;
  } else if (string == 'Water') {
    return PokemonColors.Water;
  } else if (string == 'Bug') {
    return PokemonColors.Bug;
  } else if (string == 'Fairy') {
    return PokemonColors.Fairy;
  } else if (string == 'Psychic') {
    return PokemonColors.Psychic;
  } else if (string == 'Ghost') {
    return PokemonColors.Ghost;
  } else if (string == 'Ice') {
    return PokemonColors.Ice;
  } else if (string == 'Dragon') {
    return PokemonColors.Dragon;
  } else {
    return Colors.black;
  }
}
