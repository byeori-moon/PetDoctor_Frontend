import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import '../constant/enums.dart';
import '../controller/obesity_controller.dart';
import 'obesity_age_select.dart';

class ObesityTypeSelectScreen extends StatelessWidget {
  bool isClickedButton = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ObesityController>(
      init: ObesityController(),
      builder: (ObesityController obesityController) {
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
                  "비만도를 측정할 강아지의\n견종을 선택해주세요.",
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
                        assetName: 'asset/img/obesity_dog1.png',
                        itemLabel: '말티즈',
                        dogType: DogType.Maltese,
                      ),
                      _GridItem(
                        assetName: 'asset/img/obesity_dog2.png',
                        itemLabel: '푸들',
                        dogType: DogType.Poodle,
                      ),
                      _GridItem(
                        assetName: 'asset/img/obesity_dog3.png',
                        itemLabel: '비숑프리제',
                        dogType: DogType.BichonFrise,
                      ),
                      _GridItem(
                        assetName: 'asset/img/obesity_dog4.png',
                        itemLabel: '포메라니안',
                        dogType: DogType.Pomeranian,
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
                            onPressed: obesityController.dogType == null
                                ? null
                                : () => {Get.to(ObesityAgeSelectScreen())},
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
  DogType dogType;
  final ObesityController obesityController = Get.find();
  _GridItem(
      {required this.assetName,
      required this.itemLabel,
      required this.dogType,
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
          obesityController.updateDogType(dogType);
          print(obesityController.dogType);
        },
        style: OutlinedButton.styleFrom(
          primary: DEFAULT_PINK,
          backgroundColor: obesityController.dogType == this.dogType
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
