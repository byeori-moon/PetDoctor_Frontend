import 'dart:io';

import 'package:capstonefe/controller/skin_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constant/color.dart';
import 'home_screen.dart';

class ResultSkinEach extends StatelessWidget {
  final PetSkinData item;
  const ResultSkinEach({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,

      body: FutureBuilder<File>(
        future: item.downloadImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('사진 불러오는중...'),
                CircularProgressIndicator(),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available');
          }
          return ListView(
            children: [
              Container(
                height: 440,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: DEFAULT_BLUE,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pets,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            '뽀삐의 비만도 진단기록',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'BMJUA',
                              fontSize: 28,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.pets,
                          color: Colors.white.withOpacity(0.7),
                        )
                      ],
                    ),
                    Text(
                      '${DateFormat('MM/dd').format(item.diagnosisDate)}의 기록',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontFamily: 'BMJUA',
                        fontSize: 16,
                        height: 1.2,
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Image.file(snapshot.data!),
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
                            text: '뽀삐의 증상과 연관성이 가장 높은 질병은\n',
                            style: TextStyle(
                              fontFamily: 'BMJUA',
                              fontSize: 16,
                              height: 1.25,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          TextSpan(
                            text: '${item.results[0]}',
                            style: TextStyle(
                              fontFamily: 'BMJUA',
                              fontSize: 22,
                              height: 1.25,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: '이었습니다.',
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
                    SizedBox(
                      height: 0,
                    )
                  ],
                ),
              ),
              _InformationCard(
                diseaseName: item.results[0],
                percentage: item.resultValues[0],
              ),
              _InformationCard(
                diseaseName: item.results[1],
                percentage: item.resultValues[1],
              ),
              _InformationCard(
                diseaseName: item.results[2],
                percentage: item.resultValues[2],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: DEFAULT_BLUE,
                        elevation: 0,
                        minimumSize: Size(54, 54),
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: DEFAULT_BLUE),
                        ),
                      ),
                      onPressed: () {
                        Get.delete<SkinDataController>();
                        Get.offAll(HomeScreen());
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_outlined,
                            size: 22,
                          ),
                          Text(
                            'HOME',
                            style: TextStyle(
                              fontFamily: 'BMJUA',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: DEFAULT_BLUE,
                          onPrimary: BACKGROUND_COLOR,
                          shadowColor: Colors.white.withOpacity(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {},
                        child: SizedBox(
                          height: 54,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
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
                                  '건강기록 확인하기',
                                  style: TextStyle(
                                    fontFamily: 'BMJUA',
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
