import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/pages/home_page.dart';
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
          home: InitialScreen(),
        ),
      ),
      designSize: const Size(1080, 2220),
    );
  }
}
class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1),() {
      checkSession();
    });

  }

  void checkSession() async {
    bool isLoggedIn = await checkSessionValidity();
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  Future<bool> checkSessionValidity() async {
    String? sessionId = await secureStorage.read(key: 'session_id');
    String? sessionDb = await secureStorage.read(key: 'session_db');
    String? sessionUsername = await secureStorage.read(key: 'session_username');
    String? sessionPassword = await secureStorage.read(key: 'session_password');

    if (sessionId != null && sessionDb != null && sessionUsername != null && sessionPassword != null) {
      try {
        await odooClient.authenticate(sessionDb, sessionUsername, sessionPassword);
        return true;
      } catch (e) {
        if (kDebugMode) {
          print('Error restoring session: $e');
        }
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white38,
        ),
      ),
    );
  }
}