import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';

import '../constant/enums.dart';

class ObesityController extends GetxController {
  Map<DogType, String> DogText = {
    DogType.Maltese: 'Maltese',
    DogType.Poodle: 'Poodle',
    DogType.BichonFrise: 'Bichon frise',
    DogType.Pomeranian: 'Pomeranian',
  };
  DogType? dogType;
  int age = -1;
  List<XFile?> obesityPics = [null, null, null, null];
  Map<String, dynamic>? data;


  void updateDogType(DogType selectDogType) {
    dogType = selectDogType;
    print(dogType);
    update();
  }

  void updateAge(int selectAge) {
    age = selectAge;
    print(age);
    update();
  }

// 리스트의 모든 요소가 null이 아닌지 확인하는 함수
  bool allPicsAreNotNull() {
    return obesityPics.every((item) => item != null);
  }

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource imageSource, int index) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      obesityPics[index] = XFile(pickedFile.path);
      print(obesityPics[index]!.path);
      update();
    }
  }

  Future uploadObesity() async {
    if (obesityPics.every((item) => item != null)) {
      // 이미지를 Dio를 사용하여 서버로 업로드
      final dio = Dio();
      try {
        final response = await dio.post(
            'http://petcare.kro.kr:8000/obesity/create_obesity_history/1/',
            data: FormData.fromMap({
              'breed': DogText[dogType],
              'image': await MultipartFile.fromFile(obesityPics[0]!.path),
              'image': await MultipartFile.fromFile(obesityPics[1]!.path),
              'image': await MultipartFile.fromFile(obesityPics[2]!.path),
              'image': await MultipartFile.fromFile(obesityPics[3]!.path),
            }));
        print(response.data);
        data = response.data;
      } catch (e) {
        print("에러!!!: ${e}");
      }
    }
  }
}
