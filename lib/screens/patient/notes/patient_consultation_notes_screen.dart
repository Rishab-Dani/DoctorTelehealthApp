import 'package:flutter/material.dart';

import '../../../core/utils/date_time_formatter.dart';
import '../../../models/appointment.dart';

class PatientConsultationNotesScreen extends StatelessWidget {
  final Appointment appointment;

  const PatientConsultationNotesScreen({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Consultation Notes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:.05),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [

                  _buildInfoRow(
                    Icons.local_hospital,
                    "Diagnosis",
                    appointment.diagnosis,
                  ),

                  const Divider(height: 28),

                  _buildInfoRow(
                    Icons.receipt_long,
                    "Prescription",
                    appointment.prescription,
                  ),

                  const Divider(height: 28),

                  _buildInfoRow(
                    Icons.medication,
                    "Medicines",
                    appointment.medicines,
                  ),

                  const Divider(height: 28),

                  _buildInfoRow(
                    Icons.tips_and_updates,
                    "Advice",
                    appointment.advice,
                  ),

                  const Divider(height: 28),

                  _buildInfoRow(
                    Icons.calendar_today,
                    "Follow-up Date",
                    appointment.followUpDate == null
                        ? "-"
                        : DateTimeFormatter.formatDate(
                      appointment.followUpDate!,
                    ),
                  ),

                  const Divider(height: 28),

                  _buildInfoRow(
                    Icons.note_alt,
                    "Doctor Remarks",
                    appointment.remarks,
                  ),
                ],
              ),
            ),

          ],
        )
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon,
      String title,
      String value,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.blue,
            size: 22,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                value.isEmpty ? "-" : value,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}