import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  final EdgeInsets? padding;
  final Color color;

  RoundedContainer(
      {this.height,
      this.width,
      this.padding,
      required this.child,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding != null ? padding : EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
