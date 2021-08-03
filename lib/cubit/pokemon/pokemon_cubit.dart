import 'package:Pokemon/models/pokemon.dart';
import 'package:Pokemon/repositories/graphql_client.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(PokemonInitialState()) {
    getAllPokemon();
  }

  List<Pokemon> _pokemon = [];
  int _limit = 10;

  Future<void> getAllPokemon() async {
    try {
      emit(PokemonLoadInProgressState(load: _limit == 10 ? null : true));
      final _pokemon = <Pokemon>[];
      final pokemon =
          await PokemonRepository().getAllPokemon(limit: _limit + 10);
      if (pokemon.isNotEmpty) {
        final _list = _limit == 10 ? pokemon : pokemon.sublist(_limit);
        _pokemon.addAll(_list);
      }
      emit(PokemonLoadSuccessState(_pokemon, load: _limit == 10 ? null : true));
      _limit = pokemon.length;
      this._pokemon = pokemon;
    } catch (e) {
      emit(PokemonLoadFailureState(e.toString()));
    }
  }

  Future<void> filterPokemon({required String type}) async {
    try {
      emit(PokemonLoadInProgressState());
      final pokemon = _pokemon.where((value) {
        final types = value.types;
        if (types != null) {
          return types.contains(type);
        } else {
          return false;
        }
      }).toList();
      emit(PokemonLoadSuccessState(type == 'All' ? _pokemon : pokemon.toList(),
          isFilter: true));
    } catch (e) {
      emit(PokemonLoadFailureState(e.toString()));
    }
  }
}
