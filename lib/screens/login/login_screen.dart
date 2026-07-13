import 'package:flutter/material.dart';
import '../../widgets/login/login_footer.dart';
import '../../widgets/login/login_header.dart';
import '../doctor/dashboard/doctor_dashboard_screen.dart';
import '../patient/dashboard/patient_dashboard_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    /// authProvider variable
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LoginHeader(),

              Padding(
                padding: const EdgeInsets.all(24),

                child: Form(
                  key: formKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const SizedBox(height: 15),

                      const Text(
                        "Welcome Back 👋",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        "Sign in to continue",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 30),

                      // email field
                      TextFormField(
                        controller: emailController,

                        decoration: InputDecoration(
                          hintText: "Email",

                          prefixIcon: const Icon(Icons.email),

                          filled: true,

                          fillColor: Colors.grey.shade100,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter email";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // password field
                      TextFormField(
                        controller: passwordController,
                        obscureText: _obscurePassword,

                        decoration: InputDecoration(
                          hintText: "Password",

                          prefixIcon: const Icon(Icons.lock),

                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),

                          filled: true,
                          fillColor: Colors.grey.shade100,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),

                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Password should be minimum 6 characters";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      // login button
                      SizedBox(
                        width: double.infinity,
                        height: 56,

                        child: ElevatedButton(

                          onPressed: () async {
                            if (!formKey.currentState!.validate()) return;

                            final authProvider = Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            );

                            final role = await authProvider.login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );

                            if (!mounted) return;

                            if (role == "doctor") {

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DoctorDashboardScreen(),
                                ),
                              );

                            } else if (role == "patient") {

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PatientDashboardScreen(),
                                ),
                              );

                            } else {

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Invalid email, password, or user role.",
                                  ),
                                ),
                              );

                            }
                          },

                          child: authProvider.loading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
