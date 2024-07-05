import 'package:flutter/material.dart';


class Circulos extends StatelessWidget {
  
final double radio;
final List<Color> colors;

  const Circulos({super.key, required this.radio, required this.colors});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: radio*2,
        height: radio*2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radio),
          gradient: LinearGradient(colors: colors,
                                   begin: Alignment.topRight,
                                   end: Alignment.bottomLeft)
        ),
      ),
    );
  }
}