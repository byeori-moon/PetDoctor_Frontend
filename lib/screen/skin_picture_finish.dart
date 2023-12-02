import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../constant/color.dart';
import '../controller/skin_controller.dart';
import 'skin_result.dart';

class PhotoFinish extends StatefulWidget {
  const PhotoFinish({super.key});

  @override
  State<PhotoFinish> createState() => _PhotoFinishState();
}

class _PhotoFinishState extends State<PhotoFinish> {
  final skinController = Get.find<SkinControllor>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('사진 촬영'),
        leading: null,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 25.0,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                  color: DEFAULT_PINK,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    child: Image.file(File(skinController.skinImage!.path)),
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: DEFAULT_BLUE,
                        width: 5,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                  ),
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '사진 촬영이 완료',
                            style: TextStyle(
                              fontFamily: 'BMJUA',
                              fontSize: 22,
                              height: 1.25,
                            ),
                          ),
                          TextSpan(
                            text: '되었습니다.\n\n사진을 다시 촬영하시려면\n',
                            style: TextStyle(
                              fontFamily: 'BMJUA',
                              fontSize: 18,
                              height: 1.25,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ),
                          TextSpan(
                            text: "'다시 촬영하기'",
                            style: TextStyle(
                              fontFamily: 'BMJUA',
                              fontSize: 22,
                              height: 1.25,
                            ),
                          ),
                          TextSpan(
                            text: '버튼을 클릭해주세요.',
                            style: TextStyle(
                              fontFamily: 'BMJUA',
                              fontSize: 18,
                              height: 1.25,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ),
                        ])),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14.0, right: 14.0, bottom: 17.0, top: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: DEFAULT_BLUE,
                          onPrimary: BACKGROUND_COLOR,
                          shadowColor: Colors.white.withOpacity(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          skinController.uploadSkin().then((_) {
                            Get.to(SkinResult());
                          });
                        },
                        child: SizedBox(
                          height: 54,
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
                                '상처분석하기',
                                style: TextStyle(
                                  fontFamily: 'BMJUA',
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          skinController.skinImage = null;
                          Get.back();
                        },
                        child: SizedBox(
                          height: 54,
                          child: Center(
                            child: Text(
                              '다시 촬영하기',
                              style: TextStyle(
                                fontFamily: 'BMJUA',
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          primary: DEFAULT_BLUE,
                          shadowColor: Colors.white.withOpacity(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
