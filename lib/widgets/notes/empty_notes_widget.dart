import 'package:flutter/material.dart';

class EmptyNotesWidget extends StatelessWidget {
  const EmptyNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [

          Icon(
            Icons.note_alt_outlined,
            size: 70,
            color: Colors.grey,
          ),

          SizedBox(height: 15),

          Text(
            "No Consultation Notes",
            style: TextStyle(
              fontSize: 18,
            ),
          ),

        ],
      ),
    );
  }
}