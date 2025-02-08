import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/components/my_textfield.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home_page.dart';


String username ='';
String password ='';
String db = 'demo';
String url = 'http://192.168.56.1:8069';
bool _isLoading = false;
final FlutterSecureStorage secureStorage = FlutterSecureStorage();
final odooClient = OdooClient(url);


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  
  void _handleLogin() async {
    // Create Odoo client instance with server URL (and database name if needed)
    try {
      setState(() {
        _isLoading = true;
      });

      final session = await odooClient.authenticate(db, usernameController.text, passwordController.text);
      username = usernameController.text;
      password = passwordController.text;

      await secureStorage.write(key: 'session_id', value: session.id);
      await secureStorage.write(key: 'session_username', value: username);
      await secureStorage.write(key: 'session_password', value: password);
      await secureStorage.write(key: 'session_db', value: db);
      // not so secure storage
      /*
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('session_id', session.id);
      prefs.setString('session_db', db);
      prefs.setString('session_username', username);
      prefs.setString('session_password', password);
      print(prefs);
      */
      print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");

      if (kDebugMode) {
        print("connected successfully");
      }
      if(mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } on SocketException catch (e) {
      // Handle connection problems
      Fluttertoast.showToast(
        msg: "Connection error.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade400,
        textColor: Colors.black87,
        fontSize: 45.sp,
      );

    } on OdooException catch (e) {
      // Handle API errors (likely invalid credentials)
      Fluttertoast.showToast(
        msg: "Invalid email or password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade400,
        textColor: Colors.black87,
        fontSize: 45.sp,
      );

    } catch (e) {
      // Handle API errors
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      print("Unexpected error: $e");
      Fluttertoast.showToast(
        msg: "Please try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade400,
        textColor: Colors.black87,
        fontSize: 45.sp,
      );
    } finally{
      setState(() {
        _isLoading = false;
      });
    }
  }
  Future<bool> checkSession() async {
    String? sessionId = await secureStorage.read(key: 'session_id');
    String? sessionDb = await secureStorage.read(key: 'session_db');
    String? sessionUsername = await secureStorage.read(key: 'session_username');
    String? sessionPassword = await secureStorage.read(key: 'session_password');

    if (sessionId != null && sessionDb != null && sessionUsername != null && sessionPassword != null) {
      // Try to restore the session
      try {
        await odooClient.authenticate(sessionDb, sessionUsername, sessionPassword);
        return true;  // Session restored
      } catch (e) {
        print('Error restoring session: $e');
        return false;  // Session restore failed
      }
    } else {
      return false;  // No session found
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  fit: BoxFit.cover,
                  height: 300.h,
                  width: 700.w,
                  image: const AssetImage(
                    'assets/images/logo.png',
                  )),
              SizedBox(height: 50.h),
              Text(
                "Login",
                style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50.h),
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),
              SizedBox(height: 40.h),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 50.h),

              TextButton(
                // ignore: void_checks
                onPressed: () {
                  _handleLogin();
                },
                onHover: (_) {},
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: const Color(0xff7f5e9d),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 45.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
