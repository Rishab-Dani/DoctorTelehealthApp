import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: const [

          CircleAvatar(
            radius: 42,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.local_hospital,
              color: AppColors.primary,
              size: 42,
            ),
          ),

          SizedBox(height: 20),

          Text(
            "TeleHealth",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8),

          Text(
            "Online Doctor Consultation",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

        ],
      ),
    );
  }
}