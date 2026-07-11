import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;
  final IconData icon;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(

      width: double.infinity,

      child: ElevatedButton.icon(

        icon: Icon(icon),

        label: Text(title),

        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),

        onPressed: onPressed,

      ),
    );
  }
}