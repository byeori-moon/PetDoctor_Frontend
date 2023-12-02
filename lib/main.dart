import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constant/color.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'INTER',
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            centerTitle: true,
            toolbarHeight: 56.0,
            backgroundColor: Colors.white,
            shadowColor: DEFAULT_PINK.withOpacity(0.25),
            elevation: 7.0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          textTheme: TextTheme(

          )
      ),
    ),
  );
}
