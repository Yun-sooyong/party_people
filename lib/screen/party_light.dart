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
import 'package:flutter/services.dart';

class PartyLight extends StatefulWidget {
  const PartyLight({super.key});

  @override
  State<PartyLight> createState() => _PartyLightState();
}

int r = Random().nextInt(226) + 30;
int g = Random().nextInt(226) + 30;
int b = Random().nextInt(226) + 30;
int a = Random().nextInt(226) + 30;

List<double> primaryBegin = [Random().nextDouble(), Random().nextDouble()];
List<double> primaryEnd = [Random().nextDouble(), Random().nextDouble()];
List<double> secondaryBegin = [Random().nextDouble(), Random().nextDouble()];
List<double> secondartEnd = [Random().nextDouble(), Random().nextDouble()];

int time = 4;

class _PartyLightState extends State<PartyLight> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
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
                              keyboardType: TextInputType.number,
                              // inputFormatters 를 사용하면 특정 문자만 입력받을 수 있음
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]'),
                                ),
                              ],
                              decoration: const InputDecoration(
                                hintText: '기본값 4',
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          /**
                           * 22.09.06
                           * 기능 : 애니메이션의 시간을 사용자가 입력한 값으로 지정
                           * 에러 : FormatException: Invalid number (at character 1)
                           * 원인 : parse 할 controller.text가 빌드 시 null값을 가짐
                           * 해결 : 
                           */
                          onPressed: () {
                            setState(() {
                              time = int.parse(_controller.text);
                              _controller.text = '';
                              //redrawKey = Object();
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
          /**
           * 기능 : icon button을 사용해 애니메이션에 사용된 색을 변경
           *       가능한 어두운 색이 나오지 않게끔 50 - 236의 사이값으로 생성
           * 에러 : 에러는 없지만 변경이 되지않음
           */
          IconButton(
            onPressed: () {
              setState(() {
                r = Random().nextInt(206) + 30;
                g = Random().nextInt(206) + 30;
                b = Random().nextInt(206) + 30;
                a = Random().nextInt(206) + 30;
                //redrawKey = Object();

                primaryBegin = [Random().nextDouble(), Random().nextDouble()];
                primaryEnd = [Random().nextDouble(), Random().nextDouble()];
                secondaryBegin = [Random().nextDouble(), Random().nextDouble()];
                secondartEnd = [Random().nextDouble(), Random().nextDouble()];
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
             * //TODO 가로사이즈가 길어질경우 width 의 값을 조정해 원형을 유지하며 크기를 키움
             * 
             * 에러1 : AnimateGradient 는 리빌드가 안되는것 같음
             * 해결1 : AnimateGradient 리빌드가 되지 않아 key에 UniqeKey()를 사용해 AnimateGradient의 State를 리빌드 함
             * 에러2 : Ticker Error [_AnimateGradientState created a Ticker via its TickerProviderStateMixin, but at the time dispose() was called on the mixin, that Ticker was still active. All Tickers must be disposed before calling super.dispose().]
             * 해결2 : TickerProviderStateMix 추가, AnimationController 를 사용해 직접 AnimateGradient에 추가
             
             */
            child: ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: AnimateGradient(
                controller: _animationController = AnimationController(
                  vsync: this,
                  duration: Duration(seconds: time),
                )..repeat(reverse: true),
                key: UniqueKey(),
                duration: Duration(seconds: time),
                // TODO Begin, End user input or random
                primaryBegin: Alignment(primaryBegin[0], primaryBegin[1]),
                primaryEnd: Alignment(primaryEnd[0], primaryEnd[1]),
                secondaryBegin: Alignment(secondaryBegin[0], secondartEnd[1]),
                secondaryEnd: Alignment(secondartEnd[0], secondartEnd[1]),
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
