import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/appointment.dart';
import '../../../core/theme/app_colors.dart';

class PatientInfoCard extends StatelessWidget {
  final Appointment appointment;

  const PatientInfoCard({
    super.key,
    required this.appointment,
  });

  Widget infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 17,
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
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.lightBlue,
                child: Icon(
                  Icons.person,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Patient Information",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Consultation Details",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          infoTile(
            icon: Icons.person_outline,
            title: "Patient Name",
            value: appointment.patientName,
          ),

          infoTile(
            icon: Icons.badge_outlined,
            title: "Patient ID",
            value: appointment.patientId,
          ),

          infoTile(
            icon: Icons.cake_outlined,
            title: "Age",
            value: "${appointment.age} Years",
          ),

          infoTile(
            icon: Icons.phone_outlined,
            title: "Phone",
            value: appointment.phone,
          ),

          infoTile(
            icon: Icons.schedule_outlined,
            title: "Appointment Time",
            value: DateFormat(
              "dd MMM yyyy • hh:mm a",
            ).format(
              appointment.appointmentTime,
            ),
          ),
        ],
      ),
    );
  }
}