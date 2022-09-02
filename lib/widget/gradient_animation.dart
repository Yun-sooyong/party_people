import 'package:flutter/material.dart';
import 'package:animate_gradient/animate_gradient.dart';

class GradientAni extends StatefulWidget {
  const GradientAni({super.key});

  @override
  State<GradientAni> createState() => _GradientAniState();
}

class _GradientAniState extends State<GradientAni> {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    return AnimateGradient(
      primaryBegin: Alignment.center,
      primaryEnd: Alignment.centerLeft,
      secondaryBegin: Alignment.center,
      secondaryEnd: Alignment.centerRight,
      primaryColors: const [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green
      ],
      secondaryColors: const [
        Colors.blue,
        Colors.indigo,
        Colors.purple,
        Colors.red
      ],
    );
  }
}
