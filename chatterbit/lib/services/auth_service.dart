import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/config.dart';

class AuthService {
  Future<Map<String,dynamic>> register(String email, String password, {String? name}) async {
    final r = await http.post(
      Uri.parse('$apiBase/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password, 'name': name}),
    );
    return _json(r);
  }

  Future<Map<String,dynamic>> login(String email, String password) async {
    final r = await http.post(
      Uri.parse('$apiBase/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return _json(r);
  }

  Future<Map<String,dynamic>> me(String token) async {
    final r = await http.get(
      Uri.parse('$apiBase/user/me'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return _json(r);
  }

  Map<String,dynamic> _json(http.Response r){
    final m = jsonDecode(r.body.isEmpty ? '{}' : r.body) as Map<String,dynamic>;
    if(r.statusCode>=200 && r.statusCode<300) return m;
    throw Exception(m['error'] ?? 'Request failed (${r.statusCode})');
  }
}
