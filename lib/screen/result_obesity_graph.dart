import 'package:capstonefe/screen/result_obesity_each.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constant/color.dart';
import '../controller/obesity_data_controller.dart';
import 'home_screen.dart';

class ResultObesityGraph extends StatefulWidget {
  @override
  State<ResultObesityGraph> createState() => _ResultObesityGraphState();
}

class _ResultObesityGraphState extends State<ResultObesityGraph> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime finalDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkinDataController>(
      init: SkinDataController(),
      builder: (SkinDataController obesityDataController) {
        return Scaffold(
          backgroundColor: BACKGROUND_COLOR,
          body: FutureBuilder<List<PetObesityData>>(
            future: obesityDataController.loadData(),
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
              List<FlSpot> spots = createSpots(); // Process data into spots

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                        color: DEFAULT_BLUE,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.pets,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                '뽀삐의 비만도 진단기록',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'BMJUA',
                                  fontSize: 28,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.pets,
                              color: Colors.white.withOpacity(0.7),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '6세 / 여아 / 총 16개의 진단기록',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontFamily: 'BMJUA',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'From',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'BMJUA',
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black.withOpacity(0.5),
                              side: BorderSide(color: Color(0XFFDDDDDD)),
                              minimumSize: Size(125, 23),
                            ),
                            onPressed: () async {
                              final selectedDateRange =
                                  await showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime.now(),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      initialDateRange: DateTimeRange(
                                        start: startDate,
                                        end: finalDate,
                                      ));
                              if (selectedDateRange != null) {
                                setState(() {
                                  startDate = selectedDateRange.start;
                                  finalDate = selectedDateRange.end;
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "${startDate.year.toString()}/${startDate.month.toString().padLeft(2, '0')}/${startDate.day.toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    fontFamily: 'BMJUA',
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'To',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'BMJUA',
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black.withOpacity(0.5),
                              side: BorderSide(color: Color(0XFFDDDDDD)),
                              minimumSize: Size(125, 23),
                            ),
                            onPressed: () async {
                              final selectedDateRange =
                                  await showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime.now(),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      initialDateRange: DateTimeRange(
                                        start: startDate,
                                        end: finalDate,
                                      ));
                              if (selectedDateRange != null) {
                                setState(() {
                                  startDate = selectedDateRange.start;
                                  finalDate = selectedDateRange.end;
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "${finalDate.year.toString()}/${finalDate.month.toString().padLeft(2, '0')}/${finalDate.day.toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    fontFamily: 'BMJUA',
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 380,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            width: 80,
                            height: 330,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '비만',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontFamily: 'BMJUA',
                                  ),
                                ),
                                Text(
                                  '정상',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontFamily: 'BMJUA',
                                  ),
                                ),
                                Text(
                                  '저체중',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontFamily: 'BMJUA',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              width: (400 +
                                      obesityDataController.data!.length * 50)
                                  .toDouble(),
                              height: 380,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 28),
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(
                                      show: true,
                                      drawHorizontalLine: false,
                                    ),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 50,
                                          interval: 1,
                                          getTitlesWidget:
                                              (double value, TitleMeta meta) {
                                            const style = TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'BMJUA',
                                            );
                                            String text = '';
                                            PetObesityData? item;
                                            if (value.toInt() <
                                                obesityDataController
                                                    .data!.length) {
                                              item=obesityDataController.data![value.toInt()];
                                              text = DateFormat('MM/dd')
                                                  .format(obesityDataController
                                                  .data![value.toInt()]
                                                  .diagnosisDate);
                                            }

                                            return Column(
                                              children: [
                                                Text(text, style: style),
                                                Container(
                                                  width: 57,
                                                  height: 25,
                                                  child: OutlinedButton(
                                                    onPressed: () {Get.to(ResultObesityEach(item: item!,));},
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                        vertical: 0,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 12,
                                                        ),
                                                        Text(
                                                          '상세보기',
                                                          softWrap: false,
                                                          style: TextStyle(
                                                            fontFamily: 'BMJUA',
                                                            fontSize: 10,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            color: DEFAULT_BLUE,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                            showTitles: false), // 오른쪽 y축 제거
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: Border.all(
                                        color: DEFAULT_BLUE,
                                        width: 1,
                                      ),
                                    ),
                                    minX: 0,
                                    maxX: obesityDataController.data!.length
                                            .toDouble() -
                                        1,
                                    minY: 0.5,
                                    maxY: 3.5,
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: spots,
                                        isCurved: true,
                                        color: DEFAULT_BLUE,
                                        barWidth: 5,
                                        isStrokeCapRound: true,
                                        dotData: FlDotData(show: true),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: DEFAULT_BLUE,
                            elevation: 0,
                            minimumSize: Size(54, 54),
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: DEFAULT_BLUE)),
                          ),
                          onPressed: () {
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
                            width: 180,
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
                                  '피부 진단기록 확인하러 가기',
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
                  SizedBox(
                    height: 16,
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}

List<FlSpot> createSpots() {
  final SkinDataController obesityDataController = Get.find();
  List<FlSpot> spots = [];
  for (int i = 0; i < obesityDataController.data!.length; i++) {
    final item = obesityDataController.data![i];
    double yValue;
    switch (item.result) {
      case 'under weight':
        yValue = 1.0;
        break;
      case 'normal weight':
        yValue = 2.0;
        break;
      case 'over weight':
        yValue = 3.0;
        break;
      default:
        yValue = 0.0;
        print('result is not find');
    }

    spots.add(FlSpot(i.toDouble(), yValue));
  }
  return spots;
}
