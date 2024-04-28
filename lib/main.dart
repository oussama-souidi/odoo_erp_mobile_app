import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/achats/achats.dart';
import 'package:mobile_app/modules/achats/components/AddCommand.dart';
import 'package:mobile_app/modules/facturation/facturation.dart';
import 'package:mobile_app/modules/ventes/ventes.dart';
import 'pages/login_page.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'pages/home_page.dart';

//final orpc = OdooClient('https://souidi.odoo.com');
main() {
  /*final session = await orpc.authenticate('souidi', 'souidioussama14@gmail.com', 'heisenbeerg.odoo');
  print(session.userLogin);*/
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