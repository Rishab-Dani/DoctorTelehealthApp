import 'package:flutter/material.dart';

import '../dashboard/dashboard_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    /// authProvider variable
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Doctor Login"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(

          key: formKey,

          child: Column(

            children: [

              const SizedBox(height: 40),

              const Icon(
                Icons.local_hospital,
                size: 90,
                color: Colors.blue,
              ),

              const SizedBox(height: 40),

              TextFormField(

                controller: emailController,

                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),

                validator: (value){

                  if(value==null || value.isEmpty){
                    return "Enter email";
                  }

                  return null;
                },

              ),

              const SizedBox(height:20),

              TextFormField(

                controller: passwordController,

                obscureText: true,

                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),

                validator: (value){

                  if(value==null || value.length<6){
                    return "Password should be minimum 6 characters";
                  }

                  return null;
                },

              ),

              const SizedBox(height:30),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);

                      final success = await authProvider.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (!mounted) return;

                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DashboardScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invalid email or password"),
                          ),
                        );
                      }
                    },

                  child: authProvider.loading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text("LOGIN"),

                ),

              )

            ],

          ),

        ),

      ),

    );

  }
}