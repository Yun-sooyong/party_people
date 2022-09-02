import 'package:flutter/material.dart';
import 'dart:math';

// 22.09.1 주사위 끝
// TODO 버튼에 애니메이션 적용

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int dice1 = 1;
  int dice2 = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: const Text('주사위 굴리기'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () {
              if (mounted) {
                setState(() {
                  dice1 = 1;
                  dice2 = 1;
                });
              }
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Image.asset('assets/dice/dice_$dice1.png'),
              ),
              Expanded(
                child: Image.asset('assets/dice/dice_$dice2.png'),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              elevation: 10,
              fixedSize: const Size(100, 40),
            ),
            onHover: (hover) {
              // 추후 버튼 호버링 애니메이션 추가
            },
            onPressed: () {
              if (mounted) {
                setState(() {
                  dice1 = Random().nextInt(6) + 1;
                  dice2 = Random().nextInt(6) + 1;
                });
              }
            },
            child: const Text('굴리기'),
          )
        ],
      ),
    );
  }
}
