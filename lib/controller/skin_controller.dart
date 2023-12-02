import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';

import '../constant/enums.dart';

class SkinControllor extends GetxController {
  Map<SkinType,String> skinText = {
    SkinType.head:'Head',
    SkinType.body:'Body',
    SkinType.legs:'Leg',
    SkinType.joint:'Tail',
  };
  SkinType skinType = SkinType.nothing;
  XFile? skinImage;
  Map<String, dynamic>? data;

  void updateSkinType(SkinType selectSkinType) {
    skinType = selectSkinType;
    update();
  }

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      skinImage = XFile(pickedFile.path);
      print(skinImage!.path);
    }
  }

  Future uploadSkin() async {
    if (skinImage != null) {
      // 이미지를 Dio를 사용하여 서버로 업로드
      final dio = Dio();
      try {
        final response = await dio.post(
            'http://petcare.kro.kr:8000/disease/create_disease_history/1/',
            data: FormData.fromMap({
              'image': await MultipartFile.fromFile(skinImage!.path),
              'part': skinText[skinType],
            }));
        print(response.data);
        data = response.data;
      } catch (e) {
        print("에러!!!: ${e}");
      }
    }
  }
}
