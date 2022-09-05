import 'package:flutter/material.dart';
import 'dart:math';

import 'package:animate_gradient/animate_gradient.dart';

class PartyLight extends StatefulWidget {
  const PartyLight({super.key});

  @override
  State<PartyLight> createState() => _PartyLightState();
}

class _PartyLightState extends State<PartyLight> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: size.height * 0.44,
            width: size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: AnimateGradient(
                // 컬러 부위를 랜덤으로 처리
                primaryColors: const [
                  Colors.red,
                  Colors.orange,
                ],
                secondaryColors: const [
                  Colors.blue,
                  Colors.cyan,
                ],
                child: const Center(
                  child: Text('Gradient'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
