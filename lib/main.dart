import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';

void main() {
  runApp(const DoctorApp());
}

class DoctorApp extends StatelessWidget {
  const DoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor TeleHealth',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}