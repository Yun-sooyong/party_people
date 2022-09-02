import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

class RainbowColorBall extends StatefulWidget {
  // int animation seconds, List<Color> rainbowColors,
  const RainbowColorBall({super.key});

  @override
  State<RainbowColorBall> createState() => _RainbowColorBallState();
}

class _RainbowColorBallState extends State<RainbowColorBall>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color> _animtaion;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5 /* seconds */),
    )
      ..forward()
      ..repeat();
    _animtaion = colors.animate(_controller);
  }

  Animatable<Color> colors = RainbowColorTween([
    /** rainbowColors */
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple
  ]);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _animtaion,
      builder: (context, child) {
        return Container(
          width: size.width * 0.95,
          height: size.height * 0.7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _animtaion.value,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
