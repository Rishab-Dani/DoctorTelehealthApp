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
        children: [

          Container(
            height: 84,
            width: 84,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(42),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.asset(
                "assets/images/circular_logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: 20),

          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Doc",
                  style: TextStyle(
                    color: Colors.white,
               //     color: Color(0xFF143D8D),
                   // color: Color(0xFF12B8B0),
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextSpan(
                  text: "Connect",
                  style: TextStyle(
                    color: Color(0xFF143D8D),
                 //   color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "CARE. ANYTIME. ANYWHERE.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 3,
            ),
          ),

        ],
      ),
    );
  }
}