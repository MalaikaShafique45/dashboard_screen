import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:8000/api"; 
  
  final storage = const FlutterSecureStorage();

  // LOGIN FUNCTION
  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/token/'),
        body: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        
        await storage.write(key: "access", value: data['access']);
        await storage.write(key: "refresh", value: data['refresh']);
        
        print("Login Successful!");
        return true;
      } else {
        print("Login Failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error during login: $e");
      return false;
    }
  }

  
  Future<String?> getToken() async {
    return await storage.read(key: "access");
  }

  // LOGOUT
  Future<void> logout() async {
    await storage.deleteAll();
  }
}
