import 'package:Pokemon/assets/pokemon_icons.dart';
import 'package:flutter/material.dart';

IconData stringToPokemonIcon(String string) {
  if (string == 'Flying') {
    return Pokemon.flying;
  } else if (string == 'Grass') {
    return Pokemon.grass;
  } else if (string == 'Electric') {
    return Pokemon.electric;
  } else if (string == 'Fighting') {
    return Pokemon.fighting;
  } else if (string == 'Fire') {
    return Pokemon.fire;
  } else if (string == 'Ground') {
    return Pokemon.ground;
  } else if (string == 'Normal') {
    return Pokemon.normal;
  } else if (string == 'Physic') {
    return Pokemon.psychic;
  } else if (string == 'Poison') {
    return Pokemon.poison;
  } else if (string == 'Rock') {
    return Pokemon.rock;
  } else if (string == 'Water') {
    return Pokemon.water;
  } else if (string == 'Bug') {
    return Pokemon.water;
    // return Pokemon.Bug;
  } else if (string == 'Fairy') {
    return Pokemon.water;
    // return Pokemon.Fairy;
  } else if (string == 'Psychic') {
    return Pokemon.water;
    // return Pokemon.Psychic;
  } else if (string == 'Ghost') {
    return Pokemon.water;
    // return Pokemon.Ghost;
  } else if (string == 'Ice') {
    return Pokemon.water;
    // return Pokemon.Ice;
  } else if (string == 'Dragon') {
    return Pokemon.water;
    // return Pokemon.Dragon;
  } else {
    return Pokemon.normal;
  }
}
