import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class NotesHeader extends StatelessWidget {
  final String appointmentId;

  const NotesHeader({
    super.key,
    required this.appointmentId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [

          const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.medical_services,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                const Text(
                  "Consultation Notes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "Appointment : $appointmentId",
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}