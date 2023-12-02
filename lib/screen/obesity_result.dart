import 'package:capstonefe/controller/obesity_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/color.dart';
import '../controller/obesity_controller.dart';
import 'home_screen.dart';

class ObesityResultScreen extends StatefulWidget {
  const ObesityResultScreen({super.key});

  @override
  State<ObesityResultScreen> createState() => _ObesityResultScreenState();
}

class _ObesityResultScreenState extends State<ObesityResultScreen> {
  final ObesityController obesityController = Get.find<ObesityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('결과 확인'),
      ),
      body: Center(
        child: FutureBuilder<PetObesityData?>(
          future: obesityController.uploadObesity(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('기록 불러오는중...'),
                  CircularProgressIndicator(),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('No data available');
            }
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 25.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                    height: 530,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(999)),
                            color: DEFAULT_PINK,
                          ),
                          child: Image.asset(obesityController.data!.result ==
                                  'normal weight'
                              ? 'asset/img/obesity_level3.png'
                              : obesityController.data!.result ==
                                      'over weight'
                                  ? 'asset/img/obesity_level5.png'
                                  : 'asset/img/obesity_level1.png'),
                        ),
                        Text(
                          obesityController.data!.result==
                                  'normal weight'
                              ? '적정 체중'
                              : obesityController.data!.result==
                                      'over weight'
                                  ? '과체중'
                                  : '야윈 상태',
                          style: TextStyle(
                            fontFamily: 'BMJUA',
                            fontSize: 30,
                            height: 1.25,
                          ),
                        ),
                        Text(
                          obesityController.data!.result ==
                                  'normal weight'
                              ? '적정 체중이네요. 아주 좋아요!'
                              : obesityController.data!.result ==
                                      'over weight'
                                  ? '비만이 걱정됩니다. 관리가 필요해요.'
                                  : '밥을 조금 더 주는 것이 좋겠어요.',
                          style: TextStyle(
                            fontFamily: 'BMJUA',
                            fontSize: 20,
                            height: 1.25,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: DEFAULT_BLUE,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                                side: BorderSide(color: DEFAULT_BLUE)),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('AI 로그'),
                                  content: Text('${obesityController.data}'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // 팝업창 닫기
                                      },
                                      child: Text('닫기'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            height: 42,
                            width: 166,
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
                                  '로그 확인하기',
                                  style: TextStyle(
                                    fontFamily: 'BMJUA',
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: DEFAULT_BLUE,
                          elevation: 0,
                          minimumSize: Size(54, 54),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: DEFAULT_BLUE)),
                        ),
                        onPressed: () {
                          Get.delete<ObesityController>();
                          Get.offAll(HomeScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home_outlined,
                              size: 22,
                            ),
                            Text(
                              'HOME',
                              style: TextStyle(
                                fontFamily: 'BMJUA',
                              ),
                            )
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
                        onPressed: () {},
                        child: SizedBox(
                          height: 54,
                          width: 220,
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
                                '건강기록 확인하기',
                                style: TextStyle(
                                  fontFamily: 'BMJUA',
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
