import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  bool loading = false;

  Future<bool> login(
      String email,
      String password,
      ) async {

    loading = true;
    notifyListeners();

    try {

      await _service.login(email, password);

      loading = false;
      notifyListeners();

      return true;

    } catch (e) {

      loading = false;
      notifyListeners();

      return false;
    }
  }
}