import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';



class PetSkinData {
  final int id;
  final String part;
  final List<double> resultValues;
  final List<String> results;
  final DateTime diagnosisDate;
  final String skinImageURL;
  final int pet;


  PetSkinData({required this.id, required this.part, required this.resultValues,required this.results, required this.diagnosisDate, required this.skinImageURL, required this.pet});

  factory PetSkinData.fromJson(Map<String, dynamic> json) {
    var resultValues = <double>[];
    var results = <String>[];

    for (var resultEntry in json['result']) {
      if (resultEntry[0] is String) {
        results.add(resultEntry[0]);
      }
      if (resultEntry[1] is double) {
        resultValues.add(resultEntry[1]);
      }
    }
    return PetSkinData(
      id: json['id'],
      part: json['part'],
      resultValues: resultValues,
      results: results,
      diagnosisDate: DateTime.parse(json['diagnosis_date']),
      skinImageURL: json['disease_image'],
      pet: json['pet'],
    );
  }

  Future<File> downloadImages() async {
    var dio = Dio();
    File file;

      var tempDir = await getTemporaryDirectory();
      String savePath = '${tempDir.path}/${skinImageURL.split('/').last}';
      await dio.download(skinImageURL, savePath);
      file=File(savePath);

    return file;
  }
}

class SkinDataController extends GetxController {
  List<PetSkinData>? data;
  Future<List<PetSkinData>> loadData() async{
    data=await fetchAndStorePetData();
    return data!;
  }
}

Future<List<PetSkinData>> fetchAndStorePetData() async {
  var dio = Dio();
  List<PetSkinData> petDataList = [];

  try{
    final response = await dio.get('http://petcare.kro.kr:8000/disease/disease_history/1/');
    print("응답완료: ${response.data}");
    List jsonResponse = response.data;
    for (var data in jsonResponse) {
      PetSkinData petData = PetSkinData.fromJson(data);
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
    print("General22 Error: $e");
  }
  return petDataList;
}
