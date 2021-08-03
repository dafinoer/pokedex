import 'package:Pokemon/models/pokemon.dart';
import 'package:Pokemon/pages/home/pokemon_detail.dart';
import 'package:Pokemon/utilities/string_to_pokemon_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PokemonItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonItem({Key? key, required this.pokemon}) : super(key: key);

  Widget _typeContainer(String type) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 9),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(type, style: TextStyle(color: Colors.white)));
  }

  @override
  Widget build(BuildContext context) {
    final types = pokemon.types?[0];
    String number = pokemon.number.toString();
    final _numberLength = number.length;
    if (_numberLength == 1) {
      number = '00' + number;
    } else if (_numberLength == 2) {
      number = '0' + number;
    }

    return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PokemonDetailPage(pokemon: pokemon))),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    color: Colors.black38,
                    spreadRadius: 0.5,
                    blurRadius: 5)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Image.network(
                    pokemon.image,
                    width: 200,
                  )),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9),
                decoration: BoxDecoration(
                    color: stringToPokemonColor(pokemon.types![0]).withOpacity(1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          color: Colors.black38,
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pokemon.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                        SizedBox(height: 9),
                        Row(
                          children: [
                            for (final type in pokemon.types!)
                              _typeContainer(type)
                          ],
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text('#' + number,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: Colors.white54,
                                  fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}
