import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_app/components/my_textfield.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'home_page.dart';
import 'login.dart';

final odooClient = OdooClient('http://10.0.2.2:8069');
String username ='';
String password ='';

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
      await odooClient.authenticate('demo', usernameController.text, passwordController.text);
      username = usernameController.text;
      password = passwordController.text;
      if (kDebugMode) {
        print("connected successfully");
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } on SocketException catch (e) {
      // Handle connection problems
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Connection error"),
      ));
    } on OdooException catch (e) {
      // Handle API errors (likely invalid credentials)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid email or password"),
      ));
    } catch (e) {
      // Handle API errors
      print("Unexpected error: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please try again later."),
      ));
    }
  }
  void _handleForgotPassword() async {
    final username = usernameController.text;

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8069/api/forgot-password'),
      body: {'username': username},
    );

    if (response.statusCode == 200) {
      // Password reset request sent successfully (display message to user)
      print('Password reset request sent.');
    } else {
      // Handle errors (e.g., invalid username, server error)
      print('Error sending password reset request: ${response.statusCode}');
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
              const Image(
                  fit: BoxFit.cover,
                  height: 150,
                  width: 300,
                  image: AssetImage(
                    'assets/images/logo.png',
                  )),
              const SizedBox(height: 25),
              const Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
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
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
