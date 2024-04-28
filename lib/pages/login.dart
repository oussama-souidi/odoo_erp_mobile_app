import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<String?> login(String username, String password) async {
  final url = Uri.parse('http://localhost:8069/web/session/open');
  final body = jsonEncode({
    "jsonrpc": "2.0",
    "id": 1,
    "method": "call",
    "params": {
      "db": "demo",
      "login": "admin",
      "password": "admin",
    }
  });
  final response = await http.post(url, body: body, headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['result'] != null && data['result'].containsKey('session_id')) {
      final sessionId = data['result']['session_id'];
      await storage.write(key: 'odoo_session_id', value: sessionId);
      return sessionId;
    } else {
      return null; // Handle login failure (invalid credentials)
    }
  } else {
    return null; // Handle general error (e.g., network error)
  }
}
