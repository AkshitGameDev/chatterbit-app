import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class AuthState extends ChangeNotifier {
  final _svc = AuthService();
  String? _token;
  Map<String, dynamic>? _user;
  bool _loading = false;

  String? get token => _token;
  Map<String, dynamic>? get user => _user;
  bool get loading => _loading;
  bool get isAuthed => _token != null;

  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    _token = sp.getString('jwt');
    if (_token != null) {
      try { _user = (await _svc.me(_token!))['user']; } catch (_) {}
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _loading = true; notifyListeners();
    try {
      final res = await _svc.login(email, password);
      _token = res['token']; _user = res['user'];
      final sp = await SharedPreferences.getInstance();
      await sp.setString('jwt', _token!);
    } finally { _loading = false; notifyListeners(); }
  }

  Future<void> register(String email, String password, {String? name}) async {
    _loading = true; notifyListeners();
    try {
      final res = await _svc.register(email, password, name: name);
      _token = res['token']; _user = res['user'];
      final sp = await SharedPreferences.getInstance();
      await sp.setString('jwt', _token!);
    } finally { _loading = false; notifyListeners(); }
  }

  Future<void> logout() async {
    _token = null; _user = null;
    final sp = await SharedPreferences.getInstance();
    await sp.remove('jwt');
    notifyListeners();
  }
}
