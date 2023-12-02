import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';



class PetObesityData {
  final int id;
  final String breed;
  final double resultValue;
  final String result;
  final DateTime diagnosisDate;
  final List<String> obesityImages;
  final int pet;


  PetObesityData({required this.id, required this.breed, required this.resultValue,required this.result, required this.diagnosisDate, required this.obesityImages, required this.pet});

  factory PetObesityData.fromJson(Map<String, dynamic> json) {
    return PetObesityData(
      id: json['id'],
      breed: json['breed'],
      resultValue: json['result'][0],
      result: json['result'][1],
      diagnosisDate: DateTime.parse(json['diagnosis_date']),
      obesityImages: List<String>.from(json['obesity_images']),
      pet: json['pet'],
    );
  }

  Future<List<File>> downloadImages() async {
    var dio = Dio();
    List<File> files = [];

    for (var imageUrl in obesityImages) {
      var tempDir = await getTemporaryDirectory();
      String savePath = '${tempDir.path}/${imageUrl.split('/').last}';
      await dio.download(imageUrl, savePath);
      files.add(File(savePath));
    }

    return files;
  }
}

class SkinDataController extends GetxController {
  List<PetObesityData>? data;
  Future<List<PetObesityData>> loadData() async{
    data=await fetchAndStorePetData();
    return data!;
  }
}

Future<List<PetObesityData>> fetchAndStorePetData() async {
  var dio = Dio();
  List<PetObesityData> petDataList = [];

  try{
    final response = await dio.get('http://petcare.kro.kr:8000/obesity/obesity_history/1/');
    print("응답완료: ${response.data}");
    List jsonResponse = response.data;
    for (var data in jsonResponse) {
      PetObesityData petData = PetObesityData.fromJson(data);
      await petData.downloadImages();
      petDataList.add(petData);
    }
    print(petDataList);
  } on DioError catch (e) {
    print("DioError: ${e}");
    if (e != null) {
      print("DioError Response: ${e}");
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      print("DioError Request: ${e.requestOptions}");
    }
  } catch (e) {
    print("General Error: $e");
  }
  return petDataList;
}

