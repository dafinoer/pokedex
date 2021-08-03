import 'package:Pokemon/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:Pokemon/models/pokemon.dart';
import 'package:Pokemon/utilities/string_to_pokemon_color.dart';
import 'package:Pokemon/widgets/simple_loading.dart';
import 'package:Pokemon/widgets/top_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;
  final bool isEvolution;

  const PokemonDetailPage(
      {Key? key, required this.pokemon, this.isEvolution = false})
      : super(key: key);

  @override
  _PokemonDetailPageState createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  @override
  Widget build(BuildContext context) {
    late Widget _body;
    if (!widget.isEvolution) {
      _body = FutureBuilder(
          future: Future.delayed(Duration(seconds: 1), () => true),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _detailPokemonContainer(widget.pokemon);
            }
            return SimpleLoading();
          });
    } else {
      _body = BlocProvider(
        create: (context) => PokemonDetailCubit(
            id: widget.pokemon.id, name: widget.pokemon.name),
        child: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
            builder: (context, state) {
          if (state is PokemonDetailLoadSuccessState) {
            final pokemon = state.pokemon;
            return _detailPokemonContainer(pokemon);
          } else if (state is PokemonDetailLoadFailureState) {
            return Center(
              child: Text('Sorry, looks empty'),
            );
          } else {
            return SimpleLoading();
          }
        }),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar,
      body: _body,
    );
  }

  Widget _detailPokemonContainer(Pokemon pokemon) {
    String number = pokemon.number.toString();
    final _numberLength = number.length;
    if (_numberLength == 1) {
      number = '00' + number;
    } else if (_numberLength == 2) {
      number = '0' + number;
    }

    return ListView(
      children: [
        _topContainer(pokemon, number),
        RoundedContainer(
            height: 400,
            color: stringToPokemonColor(pokemon.types![0]).withOpacity(1),
            child: _showPokemonDetail(pokemon))
      ],
    );
  }

  Container _topContainer(Pokemon pokemon, String number) {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(pokemon.name,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(fontWeight: FontWeight.bold)),
            Text('#' + number)
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (final type in pokemon.types!) _typeContainer(type),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(pokemon.classification ?? '')))
          ],
        ),
        SizedBox(height: 15),
        Align(
            alignment: Alignment.center,
            child: Image.network(pokemon.image, height: 200))
      ]),
    );
  }

  AppBar get _appBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _typeContainer(String type) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 9),
        decoration: BoxDecoration(
          color: stringToPokemonColor(type).withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(type, style: TextStyle(color: Colors.white)));
  }

  Widget _detailTab(TabDetail header) {
    switch (header) {
      case TabDetail.evolution:
        return Tab(text: 'evolution'.toUpperCase());
      case TabDetail.baseStats:
        return Tab(text: 'attacks'.toUpperCase());
      case TabDetail.about:
      default:
        return Tab(text: 'about'.toUpperCase());
    }
  }

  Widget _showPokemonDetail(Pokemon pokemon) {
    final evolutions = pokemon.evolutions;
    final isNeeded =
        (evolutions != null && evolutions.isEmpty) || evolutions == null;
    return DefaultTabController(
        length: isNeeded ? 2 : 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  _detailTab(TabDetail.about),
                  _detailTab(TabDetail.baseStats),
                  if (!isNeeded) _detailTab(TabDetail.evolution)
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _pokemonAboutTab(pokemon),
                    _pokemonBaseStatsTab(pokemon),
                    if (!isNeeded) _pokemonEvolutionTab(pokemon)
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _pokemonAboutTab(Pokemon pokemon) {
    final type = pokemon.types;
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 10),
      Container(
          height: 70,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Weight Range',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Text(pokemon.weight!.minimum +
                      ' - ' +
                      pokemon.weight!.maximum),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Height Range',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Text(pokemon.height!.minimum +
                      ' - ' +
                      pokemon.height!.maximum),
                ],
              )
            ],
          )),
      SizedBox(height: 9),
      Container(
          height: 70,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Max HP',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Text(pokemon.maxHP.toString()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Max CP',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Text(pokemon.maxCP.toString()),
                ],
              )
            ],
          )),
      SizedBox(height: 9),
      Text('Weaknesses',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      SizedBox(height: 9),
      Row(children: [
        for (final weakness in pokemon.weaknesses!) _typeContainer(weakness)
      ]),
      SizedBox(height: 9),
      Text('Resistant',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      SizedBox(height: 9),
      Row(children: [
        for (final type in pokemon.resistant!) _typeContainer(type)
      ]),
    ]));
  }

  Widget _pokemonBaseStatsTab(Pokemon pokemon) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Fast',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      SizedBox(height: 6),
      for (final fast in pokemon.attacks!.fast)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fast!.name! + ' (${fast.type!})',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.white)),
            Text(fast.damage!.toString() + ' damage',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Color(0xFF334257)))
          ],
        ),
      SizedBox(height: 9),
      Text('Special',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      SizedBox(height: 6),
      for (final special in pokemon.attacks!.special)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(special!.name! + ' (${special.type!})',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w700)),
            Text(special.damage!.toString() + ' damage',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Color(0xFF334257)))
          ],
        ),
    ]));
  }

  Widget _pokemonEvolutionTab(Pokemon pokemon) {
    final requirement = pokemon.evolutionRequirements;
    if (requirement == null) return SizedBox.shrink();
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Evolution Requirement',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(requirement.amount.toString() + ' ' + requirement.name,
                style: TextStyle(color: Color(0xFF334257)))),
        SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          for (final evolution in pokemon.evolutions!)
            InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PokemonDetailPage(
                            pokemon: evolution, isEvolution: true))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(evolution.name,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 9),
                    Image.network(
                      evolution.image,
                      height: 125,
                    ),
                  ],
                )),
        ])
      ],
    ));
  }
}

enum TabDetail { about, baseStats, evolution }
