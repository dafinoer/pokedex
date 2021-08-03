import 'package:Pokemon/utilities/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SimpleLoading extends StatelessWidget {
  const SimpleLoading();

  @override
  Widget build(BuildContext context) => Center(
    child: LayoutBuilder(
      builder: (context, constraint) {
        var size = 100.0;
        if (constraint.maxWidth < ResponsiveUi.SMALL_WIDTH) {
          size = 100.0;
        } else if (constraint.maxWidth < ResponsiveUi.MEDIUM_WIDTH) {
          size = 150.0;
        } else {
          size = 200.0;
        }
        return Container(
          constraints: BoxConstraints(
            maxHeight: size,
            maxWidth: size,
          ),
          child: Lottie.asset('lib/assets/pokedex_load.json'),
        );
      },
    ),
  );
}
