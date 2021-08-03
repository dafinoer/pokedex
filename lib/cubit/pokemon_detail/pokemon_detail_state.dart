part of 'pokemon_detail_cubit.dart';

@immutable
abstract class PokemonDetailState {}

class PokemonDetailInitial extends PokemonDetailState {}

class PokemonDetailLoadInProgressState extends PokemonDetailState {}

class PokemonDetailLoadSuccessState extends PokemonDetailState {
  final Pokemon pokemon;

  PokemonDetailLoadSuccessState(this.pokemon);

  @override
  String toString() => 'PokemonDetailLoadSuccess { pokemon : $pokemon }';
}

class PokemonDetailLoadFailureState extends PokemonDetailState {
  final String error;

  PokemonDetailLoadFailureState(this.error);

  @override
  String toString() => 'PokemonLoadError: $error';
}