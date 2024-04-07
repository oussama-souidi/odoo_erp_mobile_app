import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/achats/achats.dart';
import 'package:mobile_app/modules/achats/components/AddCommand.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
   MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Achats()
        ),
      ),
      designSize: const Size(1080, 2220),
    );
  }
}