import 'package:flutter/material.dart';

const GRADIENT_COLOR = LinearGradient(
  colors: [
    Color.fromRGBO(245, 124, 0, 1),
    Colors.pinkAccent,
    Color.fromRGBO(216,27,100,1),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  stops: const [0.2, 0.6, 1.0],
);
