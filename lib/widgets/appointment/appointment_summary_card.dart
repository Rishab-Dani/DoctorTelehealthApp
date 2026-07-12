import 'package:flutter/material.dart';
import '../../../models/appointment.dart';
import '../../../core/theme/app_colors.dart';

class AppointmentSummaryCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentSummaryCard({
    super.key,
    required this.appointment,
  });

  Widget summaryTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha:.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha:.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final bool confirmed =
        appointment.status.toLowerCase() == "confirmed";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          const Row(
            children: [

              CircleAvatar(
                radius: 24,
                backgroundColor:
                AppColors.lightBlue,
                child: Icon(
                  Icons.calendar_today,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(width: 14),

              Text(
                "Appointment Summary",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          summaryTile(
            icon: Icons.badge_outlined,
            title: "Appointment ID",
            value: appointment.patientId,
            color: Colors.blue,
          ),

          summaryTile(
            icon: Icons.person_outline,
            title: "Patient",
            value: appointment.patientName,
            color: Colors.deepPurple,
          ),

          summaryTile(
            icon: confirmed
                ? Icons.check_circle
                : Icons.pending,
            title: "Status",
            value: appointment.status,
            color: confirmed
                ? Colors.green
                : Colors.orange,
          ),
        ],
      ),
    );
  }
}