import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/color.dart';
import '../controller/skin_controller.dart';
import 'skin_picture_finish.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final skinController = Get.find<SkinControllor>();
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: DEFAULT_GREEN,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Icon(
                      CupertinoIcons.camera_viewfinder,
                      color: Colors.white.withOpacity(0.9),
                      size: 120,
                    ),
                  ),
                ),
                Text(
                  '촬영 시 주의사항\n',
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
                      skinController.getImage(ImageSource.gallery).then((_) {
                        Get.to(PhotoFinish());
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
                            '촬영하기',
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
