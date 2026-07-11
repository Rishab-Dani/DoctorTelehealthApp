import 'package:doctor_telehealth_app/providers/appointment_provider.dart';
import 'package:doctor_telehealth_app/providers/auth_provider.dart';
import 'package:doctor_telehealth_app/providers/dashboard_provider.dart';
import 'package:doctor_telehealth_app/providers/session_note_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'screens/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => AppointmentProvider()),
          ChangeNotifierProvider(create: (_) => SessionNoteProvider()),
          ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ],
        child: const DoctorApp(),
      ),
  );
}

class DoctorApp extends StatelessWidget {
  const DoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Doctor TeleHealth",
      home: const LoginScreen(),
      theme: AppTheme.lightTheme(),
    );
  }
}