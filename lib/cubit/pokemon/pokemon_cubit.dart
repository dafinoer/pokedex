import 'dart:collection';

import 'package:Pokemon/models/pokemon.dart';
import 'package:Pokemon/repositories/graphql_client.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(const PokemonInitialState()) {
    getPokemon();
  }

  int _limit = 25;
  bool _isFullPage = false;
  List<Pokemon> pokemons = [];

  Future<void> getPokemon() async {
    try {
      if (!_isFullPage) {
        emit(const PokemonLoadInProgressState());
        final pokemon = await PokemonRepository().getAllPokemon(limit: _limit);
        if (pokemon.isNotEmpty) {
          _isFullPage = pokemon.length < _limit;
          _limit = _isFullPage ? _limit : _limit += 10;
          pokemons = pokemon;
        } else {
          _isFullPage = true;
        }
        emit(PokemonLoadSuccessState(pokemons, load: _isFullPage));
      }
    } catch (e) {
      emit(PokemonLoadFailureState(e.toString()));
    }
  }

  void filterPokemon({
    required String type,
  }) async {
    try {
      _isFullPage = true;
      final pokemon = pokemons.where((value) {
        final types = value.types;
        if (types != null) {
          return types.contains(type);
        } else {
          return false;
        }
      }).toList();

      emit(PokemonLoadSuccessState(
        type == 'All' ? pokemons : pokemon.toList(),
        isFilter: true,
      ));
    } catch (e) {
      emit(PokemonLoadFailureState(e.toString()));
    }
  }

  void setBackLoadMore() {
    _isFullPage = pokemons.length < _limit;
  }
}
