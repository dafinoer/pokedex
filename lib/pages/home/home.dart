import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Pokemon/cubit/pokemon/pokemon_cubit.dart';
import 'package:Pokemon/models/pokemon.dart';
import 'package:Pokemon/pages/home/pokemon_item.dart';
import 'package:Pokemon/widgets/simple_loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonCubit, PokemonState>(
      listener: (context, state) {
        if (state is PokemonLoadInProgressState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Loading more Pokemon')));
        } else if (state is PokemonLoadSuccessState && state.pokemons.isEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('No more Pokemon')));
        }
      },
      builder: (context, state) {
        if (state is PokemonLoadSuccessState) {
          if (state.pokemons.isEmpty) {
            return const Center(child: Text('Sorry, there\'s no pokemon'));
          }
          return Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    itemCount: state.pokemons.length,
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      if(position == state.pokemons.length - 1){
                        context.read<PokemonCubit>().getPokemon();
                      }
                      final pokemon = state.pokemons[position];
                      return PokemonItem(pokemon: pokemon);
                    }),
              ),
            ],
          );
        }
        return const SimpleLoading();
      },
    );
  }
}
