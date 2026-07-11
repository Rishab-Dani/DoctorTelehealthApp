import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  bool loading = false;

  Future<String?> login(
      String email,
      String password,
      ) async {

    loading = true;
    notifyListeners();

    try {

      await _service.login(email, password);

      final role = await _service.getUserRole();

      loading = false;
      notifyListeners();

      return role;

    } catch (e) {

      loading = false;
      notifyListeners();

      return null;
    }
  }
}