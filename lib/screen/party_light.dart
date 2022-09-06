/**
 * TODO 
 * 1. AppBar 바로 밑에 끌수있는 설명서를 추가 
 * 설명서에는 '좋은 사용성을 위해 밝기를 최대로 올려달라'는 내용과
 * '유리병 등 빛이 투과되는 물건을 위에 올려 사용해달라'는 내용을 넣음
 * 
 * 2. 이 기능은 사용기가 안 좋을 경우 삭제 예정 
 * 
 * 3. 
 */

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:animate_gradient/animate_gradient.dart';

class PartyLight extends StatefulWidget {
  const PartyLight({super.key});

  @override
  State<PartyLight> createState() => _PartyLightState();
}

class _PartyLightState extends State<PartyLight> {
  final TextEditingController _controller = TextEditingController();

  int r = Random().nextInt(236) + 20;
  int g = Random().nextInt(236) + 20;
  int b = Random().nextInt(236) + 20;
  int a = Random().nextInt(236) + 20;
  int time = 4;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.timer),
            onPressed: () {
              showDialog(
                  barrierDismissible: true, // 바깥 영역 터치시 다이얼로그 닫기 여부
                  context: context,
                  builder: (BuildContext context) {
                    // 항목 추가 다이얼로그
                    return AlertDialog(
                      title: const Text('시간 설정'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            const Text('색이 변하는 시간 (기본값: 4)'),
                            TextField(
                              controller: _controller,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          /**
                           * 22.09.06
                           * 에러 : FormatException: Invalid number (at character 1)
                           * 해결 : 
                           */
                          onPressed: int.parse(_controller.text) < 10 &&
                                  _controller.text != ''
                              ? null
                              : () {
                                  setState(() {
                                    time = int.parse(_controller.text);
                                  });
                                  Navigator.of(context).pop();
                                },
                          child: const Text('확인'),
                        ),
                        TextButton(
                          child: const Text('취소'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          IconButton(
            onPressed: () {
              setState(() {
                r = Random().nextInt(206) + 50;
                g = Random().nextInt(206) + 50;
                b = Random().nextInt(206) + 50;
                a = Random().nextInt(206) + 50;
              });
            },
            icon: const Icon(Icons.repeat),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: size.height * 0.44,
            width: size.width,
            /**
             * AnimateGradient 가 Container 의 shape 에 영향을 받지않아 
             * ClipRRect를 사용해 원형을 잡음 
             * 하지만 스마트폰 사이즈에서 원형을 잡아 다른 기기나 회전시 모양이 망가짐
             * TODO 가로사이즈가 길어질경우 width 의 값을 조정해 원형을 유지하며 크기를 키움
             */
            child: ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: AnimateGradient(
                // 컬러 부위를 랜덤으로 처리
                /**
                 * [필요한 랜덤값]
                 * color 4~6 / alignment / duration
                 */
                duration: const Duration(seconds: 4),
                primaryEnd: Alignment.bottomCenter,
                primaryBegin: Alignment.centerLeft,
                secondaryBegin: Alignment.centerRight,
                secondaryEnd: Alignment.topCenter,
                primaryColors: [
                  Color.fromRGBO(r, g, b, 1),
                  Color.fromRGBO(b, r, g, 1),
                  Color.fromRGBO(g, b, r, 1),
                  Color.fromRGBO(a, r, g, 1),
                ],
                secondaryColors: [
                  Color.fromRGBO(b, g, r, 1),
                  Color.fromRGBO(r, b, g, 1),
                  Color.fromRGBO(g, r, b, 1),
                  Color.fromRGBO(b, g, a, 1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
