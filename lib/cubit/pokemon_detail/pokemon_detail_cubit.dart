import 'package:Pokemon/models/pokemon.dart';
import 'package:Pokemon/repositories/graphql_client.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pokemon_detail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  PokemonDetailCubit({required id, required name}) : super(PokemonDetailInitial()) {
    getPokemon(id: id, name: name);
  }

  Future<void> getPokemon({required String id, required String name}) async {
    try {
      emit(PokemonDetailLoadInProgressState());
      final pokemon = await PokemonRepository().getPokemonByIdOrName(name: name, id: id);
      if (pokemon.weaknesses != null) {
        emit(PokemonDetailLoadSuccessState(pokemon));
      } else {
        emit(PokemonDetailLoadFailureState('Sorry there\'s no pokemon'));
      }
    } catch (e) {
      emit(PokemonDetailLoadFailureState(e.toString()));
    }
  }
}
