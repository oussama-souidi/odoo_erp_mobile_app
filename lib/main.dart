import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pages/login_page.dart';



main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
   const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => const SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        ),
      ),
      designSize: const Size(1080, 2220),
    );
  }
}