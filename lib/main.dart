import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/achats/components/details_page.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => const SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage()
        ),
      ),
      designSize: const Size(1080, 2220),
    );
  }
}