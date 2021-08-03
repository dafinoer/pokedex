part of 'pokemon_cubit.dart';

@immutable
abstract class PokemonState {}

class PokemonInitialState extends PokemonState {}

class PokemonLoadInProgressState extends PokemonState {
  final bool? load;

  PokemonLoadInProgressState({this.load});

  @override
  String toString() => 'PokemonLoadSuccess { pokemons : $load }';
}

class PokemonLoadSuccessState extends PokemonState {
  final List<Pokemon> pokemons;
  final bool? load;
  final bool isFilter;

  PokemonLoadSuccessState(this.pokemons, {this.load, this.isFilter = false});

  @override
  String toString() => 'PokemonLoadSuccess { pokemons : $pokemons }';
}

class PokemonLoadFailureState extends PokemonState {
  final String error;

  PokemonLoadFailureState(this.error);

  @override
  String toString() => 'PokemonLoadError: $error';
}
