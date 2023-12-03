import 'dart:io';
import 'package:capstonefe/controller/obesity_data_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constant/color.dart';

class ResultObesityEach extends StatelessWidget {
  final PetObesityData item;
  const ResultObesityEach({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Center(
        child: FutureBuilder<List<File>>(
          future: item.downloadImages(),
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                      color: DEFAULT_BLUE,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'BMJUA',
                              fontSize: 16,
                              height: 1.2),
                          children: [
                            TextSpan(
                              text:
                                  '${DateFormat('MM/dd').format(item.diagnosisDate)}의 기록\n\n뽀삐의 BCS를 분석한 결과\n',
                            ),
                            TextSpan(
                                text: item.result == 'over weight'
                                    ? '과체중'
                                    : item.result == 'under weight'
                                        ? '저체중'
                                        : '정상',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                )),
                            TextSpan(
                              text: '이었습니다.',
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.count(
                      childAspectRatio: 7 / 9,
                      crossAxisCount: 2,
                      mainAxisSpacing: 29,
                      crossAxisSpacing: 12,
                      scrollDirection: Axis.vertical,
                      children: [
                        _GridItem(
                          img: snapshot.data![0],
                          itemLabel: '0',
                        ),
                        _GridItem(
                          img: snapshot.data![1],
                          itemLabel: '90',
                        ),
                        _GridItem(
                          img: snapshot.data![2],
                          itemLabel: '180',
                        ),
                        _GridItem(
                          img: snapshot.data![3],
                          itemLabel: '270',
                        ),
                        _GridItem(
                          img: snapshot.data![3],
                          itemLabel: '270',
                        ),
                        Column(
                          children: [
                            Container(
                              width: 165,
                              height: 165,
                              decoration: BoxDecoration(
                                image:DecorationImage(
                                  image: AssetImage('asset/img/logo.jpg'),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                fontFamily: "BMJUA",
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  String itemLabel;
  File img;
  _GridItem({required this.itemLabel, required this.img, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
          dashPattern: [4, 4],
          strokeWidth: 1,
          color: DEFAULT_BLUE,
          child: Container(
            width: 165,
            height: 165,
            child: Image.file(img),
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          itemLabel,
          style: TextStyle(
            fontFamily: "BMJUA",
            fontSize: 18,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
