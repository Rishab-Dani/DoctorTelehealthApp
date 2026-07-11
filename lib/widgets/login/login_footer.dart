import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [

        SizedBox(height: 30),

        Icon(
          Icons.lock,
          color: Colors.grey,
        ),

        SizedBox(height: 8),

        Text(
          "Protected by Firebase Authentication",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),

      ],
    );
  }
}