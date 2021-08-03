import 'package:Pokemon/cubit/pokemon/pokemon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pokemon/pages/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;

    return MaterialApp(
      title: 'PokeDex',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.latoTextTheme(textTheme),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black87,
          ),
          textTheme: GoogleFonts.latoTextTheme(textTheme),
        ),
      ),
      home: BlocProvider(
        create: (context) => PokemonCubit(),
        child: Dashboard(),
      ),
    );
  }
}
