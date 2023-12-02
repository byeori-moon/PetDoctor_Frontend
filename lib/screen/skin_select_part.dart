import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import '../constant/enums.dart';
import '../controller/skin_controller.dart';
import 'skin_take_picture.dart';

class SkinSelectPartScreen extends StatelessWidget {
  bool isClickedButton = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkinControllor>(
      init: SkinControllor(),
      builder: (SkinControllor skinController) {
        return Scaffold(
          backgroundColor: BACKGROUND_COLOR,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 22.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 110,
                ),
                Text(
                  "피부 질환이 의심되는\n부위를 선택해주세요.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 27,
                    fontFamily: 'BMJUA',
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 22,
                    crossAxisSpacing: 22,
                    scrollDirection: Axis.vertical,
                    children: [
                      _GridItem(
                        assetName: 'asset/img/skin_dog1.png',
                        itemLabel: '머리',
                        skinType: SkinType.head,
                      ),
                      _GridItem(
                        assetName: 'asset/img/skin_dog2.png',
                        itemLabel: '몸통',
                        skinType: SkinType.body,
                      ),
                      _GridItem(
                        assetName: 'asset/img/skin_dog3.png',
                        itemLabel: '다리',
                        skinType: SkinType.legs,
                      ),
                      _GridItem(
                        assetName: 'asset/img/skin_dog4.png',
                        itemLabel: '연접부',
                        skinType: SkinType.joint,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 54.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          '이전',
                          style: TextStyle(
                            fontFamily: 'BMJUA',
                            fontSize: 18,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          primary: DEFAULT_BLUE,
                          side: BorderSide(
                            color: DEFAULT_BLUE,
                          ),
                          backgroundColor: BACKGROUND_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 28),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: DEFAULT_BLUE,
                                onPrimary: BACKGROUND_COLOR,
                                shadowColor: Colors.white.withOpacity(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            onPressed:
                                skinController.skinType == SkinType.nothing
                                    ? null
                                    : () => {Get.to(CameraScreen())},
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
                                  '선택완료',
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
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GridItem extends StatelessWidget {
  String assetName;
  String itemLabel;
  SkinType skinType;
  final SkinControllor skinController = Get.find();
  _GridItem(
      {required this.assetName,
      required this.itemLabel,
      required this.skinType,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: DEFAULT_PINK,
          offset: Offset(0, 0),
          blurRadius: 10,
          spreadRadius: 1,
        )
      ]),
      child: OutlinedButton(
        onPressed: () {
          skinController.updateSkinType(skinType);
          print(skinController.skinType);
        },
        style: OutlinedButton.styleFrom(
          primary: DEFAULT_PINK,
          backgroundColor: skinController.skinType == this.skinType
              ? DEFAULT_PINK
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // 둥근 모서리 설정
          ),
          side: BorderSide(
            color: DEFAULT_PINK,
            width: 3,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(assetName),
              width: 120,
              height: 107,
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
        ),
      ),
    );
  }
}
