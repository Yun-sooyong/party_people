import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class Wheel extends StatefulWidget {
  const Wheel({super.key});

  @override
  State<Wheel> createState() => _WheelState();
}

List<String> items = <String>[];

class _WheelState extends State<Wheel> {
  final StreamController<int> _streamController =
      StreamController<int>.broadcast();
  final TextEditingController _addItemController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _addItemController.dispose();
    _streamController.close();
  }

  //bool _isNull = true;
  bool _isSpinning = false;

  String itemsValue = '';
  late int randomVar;

  @override
  Widget build(BuildContext context) {
    //int randomVar = Fortune.randomInt(0, items.length);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      /** AppBar */
      appBar: AppBar(
        title: const Text('랜덤 룰렛'),
        centerTitle: true,
        actions: [
          // 항목 추가 액션 버튼
          // TODO 조각 바탕 컬러 지정 추가
          IconButton(
            tooltip: '항목 추가',
            onPressed: () {
              showDialog(
                  barrierDismissible: true, // 바깥 영역 터치시 다이얼로그 닫기 여부
                  context: context,
                  builder: (BuildContext context) {
                    // 항목 추가 다이얼로그
                    return AlertDialog(
                      title: const Text('항목 추가'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            const Text('추가할 내용을 입력 '),
                            TextField(
                              controller: _addItemController,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('확인'),
                          onPressed: () {
                            setState(() {
                              items.add(_addItemController.text);
                              _addItemController.text = '';
                              //if (items.length > 2) _isNull = false;
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
            onPressed: () {
              showDialog(
                  barrierDismissible: true, // 바깥 영역 터치시 다이얼로그 닫기 여부
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('항목 제거'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            const Text('삭제할 내용을 입력 '),
                            TextField(
                              controller: _addItemController,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('확인'),
                          onPressed: () {
                            setState(() {
                              items.remove(_addItemController.text);
                              _addItemController.text = '';
                              //if (items.length < 2) _isNull = true;
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
            icon: const Icon(Icons.remove),
          )
        ],
      ),
      /** BODY
       * Text / Wheel / ElevatedButton
       * Fortune Wheel 의 결과를 보여주는 Text Widget 과 Fortune Wheel, Wheel 을 돌리는 버튼으로 구성
       * Wheel 의 내용을 수정할 수 있도록 하기위해 AppBar 에 버튼을 추가해줌 
       * 구체적인 디자인은 앱이 완성된 이후 다시 수정 
       * Wheel 의 내용이 1개 이하가 되면 에러가 발생
       * 빌드 시 2개 이상의 항목이 들어가 있거나 다른 Widget을 넣고 item을 2개 이상 추가하면 Wheel이 보이도록 해야함
       */
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: items.length < 2
            // 안내문
            ? Center(
                child: Container(
                  height: size.height * 0.4,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.blueGrey, width: 2),
                      shape: BoxShape.circle),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        text: '항목을 2개 이상 추가해주세요',
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(text: '\n현재: ${items.length}'),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            // 본체
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Wheel Value Text
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.7,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Colors.deepOrange,
                        ),
                        borderRadius: BorderRadius.circular(25)),
                    // Value Text
                    child: Center(
                      child: Text(
                        itemsValue,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  // Fortune Wheel Main
                  // items.length < 2 일때 Fortune Wheel 에러가 나기때문에
                  // 안내메세지가 나오게 함
                  SizedBox(
                    height: size.height * 0.4,
                    width: size.width,
                    // fortune wheel
                    child: FortuneWheel(
                      onAnimationStart: () {
                        setState(() {
                          _isSpinning = true;
                        });
                      },
                      onAnimationEnd: () {
                        setState(() {
                          _isSpinning = false;
                          itemsValue = items[randomVar];
                        });
                      },
                      indicators: const [
                        FortuneIndicator(
                            child: TriangleIndicator(
                              color: Colors.amber,
                            ),
                            alignment: Alignment.topCenter)
                      ],
                      animateFirst: false,
                      duration: const Duration(milliseconds: 6000),
                      selected: _streamController.stream,
                      // items 의 크기가 2보다 작을 경우 에러 발생
                      // TODO items 의 길이가 1, 0 일 경우 해결방안
                      // TODO FortuneItem and FortuneStyle을 사용해 조각당 색 시정등 사용자 지정 편의성 개선
                      items: [
                        for (var it in items)
                          FortuneItem(
                            child: Text(it),
                          ),
                      ],
                    ),
                  ),
                  // value text

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 30),
                    ),
                    onPressed: _isSpinning
                        ? null
                        : () {
                            setState(() {
                              itemsValue = '';
                            });
                            _streamController.add(
                              //Fortune.randomInt(0, items.length),
                              randomVar = Fortune.randomInt(0, items.length),
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
