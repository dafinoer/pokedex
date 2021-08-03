import 'package:Pokemon/assets/pokemon_icons.dart';
import 'package:Pokemon/cubit/pokemon/pokemon_cubit.dart';
import 'package:Pokemon/pages/home/home.dart';
import 'package:Pokemon/utilities/string_to_pokemon_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatelessWidget {
  Widget get _floatingActionButton {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      onPressed: null,
      child: SvgPicture.asset('lib/assets/pokedex.svg'),
    );
  }

  Widget get _bottomNavigationBar {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.black,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 2,
        child: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          unselectedFontSize: 12.0,
          selectedFontSize: 12.0,
          selectedItemColor: Colors.grey,
          items: [
            const BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: '',
            )
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red,
      title: Text('Pokedex', style: TextStyle(color: Colors.white)),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => _showFilterModal(context),
              child: Icon(
                Icons.filter_alt_rounded,
                color: Colors.white,
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Builder(
          builder: (context) => Scaffold(
                appBar: _appBar(context),
                floatingActionButton: _floatingActionButton,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: _bottomNavigationBar,
                body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: HomePage()),
              )),
    );
  }

  void _showFilterModal(BuildContext _context) {
    showModalBottomSheet(
        context: _context,
        builder: (context) {
          return SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Filter by'.toUpperCase()))),
              Divider(),
              _listTile('All', Icons.catching_pokemon, context, _context),
              _listTile('Flying', Pokemon.flying, context, _context),
              _listTile('Grass', Pokemon.grass, context, _context),
              _listTile('Ground', Pokemon.ground, context, _context),
              _listTile('Normal', Pokemon.normal, context, _context),
              _listTile('Poison', Pokemon.poison, context, _context),
              _listTile('Psychic', Pokemon.psychic, context, _context),
              _listTile('Rock', Pokemon.rock, context, _context),
              _listTile('Water', Pokemon.water, context, _context),
              _listTile('Electric', Pokemon.electric, context, _context),
              _listTile('Fighting', Pokemon.fighting, context, _context),
              _listTile('Fire', Pokemon.fire, context, _context),
            ],
          ));
        });
  }

  ListTile _listTile(String title, IconData icon, BuildContext context, BuildContext _context) {
    return ListTile(
      leading:
          new Icon(icon, color: stringToPokemonColor(title).withOpacity(0.97)),
      title: new Text(title),
      onTap: () {
        Navigator.pop(context);
        try {
          BlocProvider.of<PokemonCubit>(_context).filterPokemon(type: title);
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
