import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../constant/color.dart';
import '../controller/obesity_controller.dart';
import 'obesity_result.dart';

class ObesityTakePictureScreen extends StatelessWidget {
  const ObesityTakePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ObesityController>(
      init: ObesityController(),
      builder: (ObesityController obesityController) {
        return Scaffold(
          appBar: AppBar(
            title: Text('사진 촬영'),
          ),
          backgroundColor: BACKGROUND_COLOR,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 50.0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    childAspectRatio: 7 / 9,
                    crossAxisCount: 2,
                    mainAxisSpacing: 29,
                    crossAxisSpacing: 12,
                    scrollDirection: Axis.vertical,
                    children: [
                      _GridItem(
                        index: 0,
                        itemLabel: '0',
                      ),
                      _GridItem(
                        index: 1,
                        itemLabel: '90',
                      ),
                      _GridItem(
                        index: 2,
                        itemLabel: '180',
                      ),
                      _GridItem(
                        index: 3,
                        itemLabel: '270',
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: DEFAULT_BLUE,
                    onPrimary: BACKGROUND_COLOR,
                    shadowColor: Colors.white.withOpacity(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: obesityController.allPicsAreNotNull()
                      ? () {
                          obesityController.data = {
                            "result": [0.47, "over weight"],
                          };
                          Get.to(ObesityResultScreen());
                          /*obesityController.uploadObesity().then((_) {
                            Get.to(ObesityResultScreen());
                          });*/
                        }
                      : null,
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
                    Get.back();
                  },
                  child: SizedBox(
                    height: 54,
                    child: Center(
                      child: Text(
                        '촬영 도움말',
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
        );
      },
    );
  }
}

class _GridItem extends StatelessWidget {
  String itemLabel;
  int index;
  final ObesityController obesityController = Get.find();
  _GridItem({required this.itemLabel, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
          dashPattern: [4, 4],
          strokeWidth: 1,
          color: DEFAULT_BLUE,
          child: obesityController.obesityPics[index] == null
              ? Container(
                  width: 165,
                  height: 165,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                  ),
                  child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Colors.transparent), // 클릭 효과 없앰
                      ),
                      onPressed: () {
                        obesityController.getImage(ImageSource.gallery, index);
                      },
                      child: Center(
                          child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black.withOpacity(0.5),
                      ))),
                )
              : GestureDetector(
                  onTap: () {
                    obesityController.getImage(ImageSource.gallery, index);
                  },
                  child: Image.file(
                    File(obesityController.obesityPics[index]!.path),
                    fit: BoxFit.fill,
                    width: 165,
                    height: 165,
                  ),
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
