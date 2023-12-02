import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import '../controller/obesity_controller.dart';
import 'obesity_take_pickture.dart';

class ObesityHelpScreen extends StatefulWidget {
  const ObesityHelpScreen({super.key});

  @override
  State<ObesityHelpScreen> createState() => _ObesityHelpScreenState();
}

class _ObesityHelpScreenState extends State<ObesityHelpScreen> {
  final obesityController = Get.find<ObesityController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('사진 촬영'),
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
                SizedBox(
                  height:0,
                ),
                Text(
                  '촬영 도움말\n',
                  style: TextStyle(
                    fontFamily: 'BMJUA',
                    fontSize: 30,
                    height: 1.25,
                  ),
                ),
                Text(
                  '-어쩌구저쩌구~~~\n-어쩌구저쩌구\n-어쩌구\n-어쩌구저쩌구~~~\n-어쩌구저쩌구\n-어쩌구\n-어쩌구\n',
                  style: TextStyle(
                    fontFamily: 'BMJUA',
                    fontSize: 20,
                    height: 1.25,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14.0, right: 14.0, bottom: 17.0, top: 30.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: DEFAULT_BLUE,
                      onPrimary: BACKGROUND_COLOR,
                      shadowColor: Colors.white.withOpacity(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      Get.to(ObesityTakePictureScreen());
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
                            '촬영하러 가기',
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
          ),
        ),
      ),
    );
  }
}
