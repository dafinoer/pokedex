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

  List pokemons = <Pokemon>[];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonCubit, PokemonState>(listener: (context, state) {
      if (state is PokemonLoadInProgressState) {
        final isLoad = state.load;
        if (isLoad != null && isLoad) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Loading more Pokemon')));
          setState(() {
            isLoading = false;
          });
        }
      } else if (state is PokemonLoadSuccessState && state.pokemons.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No more Pokemon')));
      }
    }, builder: (context, state) {
      if (state is PokemonLoadSuccessState) {
        if (state.isFilter == true) {
          pokemons = state.pokemons;
        } else {
          pokemons.addAll(state.pokemons);
        }
        if (pokemons.isEmpty) {
          return Center(
            child: Text('Sorry, there\'s no pokemon'),
          );
        }
      } else {
        if (pokemons.isEmpty) return SimpleLoading();
      }
      return Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: ListView.separated(
                controller: _scrollController
                  ..addListener(() async {
                    if (_scrollController.position.atEdge &&
                        _scrollController.position.pixels != 0 &&
                        !(state is PokemonLoadInProgressState)) {
                      if (state is PokemonLoadSuccessState && !isLoading) {
                        final load = state.load;
                        if (load == null) {
                          BlocProvider.of<PokemonCubit>(context)
                              .getAllPokemon();
                          setState(() {
                            isLoading = true;
                          });
                        }
                      }
                    }
                  }),
                separatorBuilder: (context, index) {
                  return SizedBox(height: 15);
                },
                padding: EdgeInsets.symmetric(horizontal: 3),
                itemCount: pokemons.length,
                shrinkWrap: true,
                itemBuilder: (context, position) {
                  final pokemon = pokemons[position];
                  return PokemonItem(pokemon: pokemon);
                }),
          ),
        ],
      );
    });
  }
}
