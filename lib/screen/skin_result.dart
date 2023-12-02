import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import '../controller/skin_controller.dart';
import 'skin_take_picture.dart';

class SkinResult extends StatefulWidget {
  const SkinResult({super.key});

  @override
  State<SkinResult> createState() => _SkinResultState();
}

class _SkinResultState extends State<SkinResult> {
  final skinController = Get.find<SkinControllor>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text(
          '상처분석',
        ),
        leading: null,
      ),
      body: ListView(
        children: [
          Container(
            height: 410,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              color: DEFAULT_BLUE,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: Image.file(File(skinController.skinImage!.path)),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pets,
                      size: 16.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      '피부의 증상 유사도 분석 결과 안내',
                      style: TextStyle(
                        fontFamily: 'BMJUA',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'ㅇㅇ님의 증상과 연관성이 가장 높은 질병은\n',
                        style: TextStyle(
                          fontFamily: 'BMJUA',
                          fontSize: 16,
                          height: 1.25,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      TextSpan(
                        text: '${skinController.data!['result'][0][0]}',
                        style: TextStyle(
                          fontFamily: 'BMJUA',
                          fontSize: 22,
                          height: 1.25,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: '입니다.',
                        style: TextStyle(
                          fontFamily: 'BMJUA',
                          fontSize: 16,
                          height: 1.25,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: BACKGROUND_COLOR,
                    onPrimary: DEFAULT_BLUE,
                    shadowColor: Colors.black,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  onPressed: () {
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('AI 로그'),
                        content: Text('${skinController.data}'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // 팝업창 닫기
                            },
                            child: Text('닫기'),
                          ),
                        ],
                      );
                    },);
                  },
                  child: SizedBox(
                    height: 42,
                    width: 166,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pets,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          '로그 확인하기',
                          style: TextStyle(
                            fontFamily: 'BMJUA',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //
          _InformationCard(
              diseaseName: skinController.data!['result'][0][0],
              percentage: skinController.data!['result'][0][1]),
          _InformationCard(
              diseaseName: skinController.data!['result'][1][0],
              percentage: skinController.data!['result'][1][1]),
          _InformationCard(
              diseaseName: skinController.data!['result'][2][0],
              percentage: skinController.data!['result'][2][1]),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}

class _InformationCard extends StatelessWidget {
  double percentage;
  String diseaseName;
  _InformationCard(
      {required this.diseaseName, required this.percentage, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 10,
                color: DEFAULT_PINK,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: DEFAULT_BLUE,
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.pets,
                          size: 16.0,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: '${diseaseName.replaceAll('/', '/\n')} ',
                                style: TextStyle(
                                  fontFamily: 'BMJUA',
                                  fontSize: 20,
                                  height: 1.25,
                                ),
                              ),
                              TextSpan(
                                text: '증상이 있을 확률',
                                style: TextStyle(
                                  fontFamily: 'BMJUA',
                                  fontSize: 12,
                                  height: 1.25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${(percentage * 100).toInt().toString()}%',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "BMJUA",
                        fontSize: 16,
                        height: 1.25,
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 162,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(999)),
                            color: DEFAULT_PINK,
                          ),
                        ),
                        Container(
                          width: 162 * percentage,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(999)),
                            color: DEFAULT_PURPLE,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.pets,
                    size: 16.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  '${diseaseName} 증상 예시',
                  style: TextStyle(
                    fontFamily: 'BMJUA',
                    fontSize: 18,
                    height: 1.25,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: DEFAULT_PINK,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: DEFAULT_PINK,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: DEFAULT_PINK,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
