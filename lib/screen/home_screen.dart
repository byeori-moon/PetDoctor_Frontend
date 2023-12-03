import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import 'obesity_dogtype_select.dart';
import 'result_select.dart';
import 'skin_select_part.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 50),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _TitleText(),
                  SizedBox(height: 5.0),
                  _SkinDiagnosisButton(),
                  _ObesityDiagnosisButton(),
                  _BigButton(),
                ],
              ),
            ),
          ),
          _BottomBar(),
        ],
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: Text(
            '무엇을\n체크할까요?',
            style: TextStyle(
              fontFamily: 'BMJUA',
              fontSize: 35,
              height: 1.2,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }
}

class _SmallButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String titleText;
  final String descriptionText;
  final Color buttonColor;

  const _SmallButton({
    required this.onPressed,
    required this.buttonColor,
    required this.titleText,
    required this.descriptionText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 216.0,
      height: 150.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white.withOpacity(0.8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                titleText,
                style: TextStyle(
                  fontFamily: 'BMJUA',
                  fontSize: 26,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(
                      Icons.pets,
                      size: 13.0,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    descriptionText,
                    style: TextStyle(
                      fontFamily: 'BMJUA',
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SkinDiagnosisButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          _SmallButton(
            titleText: '피부 진단하기',
            descriptionText: '뭐뭐 등 5가지 피부질환 진단',
            buttonColor: DEFAULT_PINK,
            onPressed: () {
              Get.to(SkinSelectPartScreen());
            },
          ),
          Positioned(
            left: -130,
            child: Image.asset('asset/img/skin_dog.png'),
          ),
        ],
      ),
    );
  }
}

class _ObesityDiagnosisButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          _SmallButton(
            titleText: '비만도 진단하기',
            descriptionText: '1~5단계의 비만도 판단',
            buttonColor: DEFAULT_GREEN,
            onPressed: () {
              Get.to(ObesityTypeSelectScreen());
            },
          ),
          Positioned(
            right: -130,
            child: Image.asset('asset/img/eye_dog.png'),
          ),
        ],
      ),
    );
  }
}

class _BigButton extends StatelessWidget {
  const _BigButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 150.0,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(DEFAULT_LIGHTPURPLE),
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.only(left: 15.0, right: 15.0, top: 97.0, bottom: 7.0),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),

            ),
            onPressed: () {
              Get.to(ResultSelect());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.pets, color: Colors.black.withOpacity(0.8)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '우리아이 건강기록',
                        style: TextStyle(
                          fontFamily: 'BMJUA',
                          fontSize: 26,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.pets, color: Colors.black.withOpacity(0.8)),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          child: ElevatedButton(
            onPressed: () {
              Get.to(ResultSelect());
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white.withOpacity(0),
              shadowColor: Colors.white.withOpacity(0),
              elevation: 0,
            ),
            child: Image.asset('asset/img/fat_dog.png'),
          ),
        )
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: DEFAULT_BLUE.withOpacity(0.25),
            blurRadius: 4.0,
            offset: Offset(0, -1),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_outline, color: DEFAULT_BLUE),
          ),
          Container(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
              color: DEFAULT_BLUE,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.home_outlined, color: BACKGROUND_COLOR),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_outlined, color: DEFAULT_BLUE),
          ),
        ],
      ),
    );
  }
}
