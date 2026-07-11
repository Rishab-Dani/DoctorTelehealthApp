import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(

      controller: controller,

      maxLines: maxLines,

      decoration: InputDecoration(

        hintText: hint,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),

      ),
    );
  }
}