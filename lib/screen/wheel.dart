import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class Wheel extends StatefulWidget {
  const Wheel({super.key});

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  final StreamController<int> _controller = StreamController<int>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _controller.close();
  }

  List<String> items = <String>[
    '1',
    '2',
    '3',
  ];
  bool _isNull = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('랜덤 룰렛'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: '항목 추가',
            onPressed: () {
              showDialog(
                  barrierDismissible: true, // 바깥 영역 터치시 다이얼로그 닫기 여부
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('항목 추가'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            const Text('추가할 내용을 입력 '),
                            TextField(
                              controller: _textEditingController,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('확인'),
                          onPressed: () {
                            setState(() {
                              items.add(_textEditingController.text);
                              _textEditingController.text = '';
                              if (items.length > 2) _isNull = false;
                            });
                            Navigator.of(context).pop();
                          },
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
            icon: const Icon(Icons.add),
          ),
          IconButton(
            tooltip: '항목 제거',
            onPressed: () {},
            icon: const Icon(Icons.remove),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: FortuneWheel(
                //physics: PanState(),
                indicators: const [
                  FortuneIndicator(
                      child: TriangleIndicator(
                        color: Colors.amber,
                      ),
                      alignment: Alignment.topCenter)
                ],
                animateFirst: false,
                duration: const Duration(milliseconds: 6000),
                selected: _controller.stream,
                items: _isNull
                    ? [
                        // true /
                        for (var it in items)
                          FortuneItem(
                            child: Text(it),
                          ),
                      ]
                    : [
                        // false /
                        for (var it in items)
                          FortuneItem(
                            child: Text(it),
                          ),
                      ],
              ),
            ),
            //Text(PanPhysics().value.toString()),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(80, 30),
              ),
              onPressed: () {
                //print(PanState().isPanning);
                const PanState().isPanning == true
                    ? null
                    : _controller.add(
                        Fortune.randomInt(0, items.length),
                      );
              },
              child: const Text('돌리기'),
            )
          ],
        ),
      ),
    );
  }
}
