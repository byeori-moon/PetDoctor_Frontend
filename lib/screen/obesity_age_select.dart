import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/color.dart';
import '../constant/enums.dart';
import '../controller/obesity_controller.dart';
import 'obesity_picture_help.dart';

class ObesityAgeSelectScreen extends StatefulWidget {
  const ObesityAgeSelectScreen({super.key});

  @override
  State<ObesityAgeSelectScreen> createState() => _ObesityAgeSelectScreenState();
}

class _ObesityAgeSelectScreenState extends State<ObesityAgeSelectScreen> {
  final ObesityController obesityController = Get.find<ObesityController>();
  List<int> dropdownItems=[-1,0,1,2,3,4,5,6,7,8,9,10];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 22.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "비만도를 측정할 강아지의\n나이를 선택해주세요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'BMJUA',
                height: 1.5,
              ),
            ),
            Image.asset(
              WhatDogImage(obesityController.dogType ?? DogType.Pomeranian),
              width: 200,
              height: 190,
              fit: BoxFit.contain,
            ),
            DropdownButton<int>(
              value: obesityController.age,
              onChanged: (int? newValue) {
                setState(() {
                  obesityController.updateAge(newValue!);
                });
              },
              items: dropdownItems
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value==-1?'강아지의 나이를 선택해주세요.':value.toString()+'살'),
                );
              }).toList(),
            ),
            SizedBox(
              height:130,
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
                        onPressed: obesityController.age == -1
                            ? null
                            : () => {Get.to(ObesityHelpScreen())},
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
  }
}

String WhatDogImage(DogType dogType) {
  switch (dogType) {
    case DogType.Maltese:
      return 'asset/img/obesity_dog1.png';
    case DogType.Poodle:
      return 'asset/img/obesity_dog2.png';
    case DogType.BichonFrise:
      return 'asset/img/obesity_dog3.png';
    case DogType.Pomeranian:
      return 'asset/img/obesity_dog4.png';
  }
}
