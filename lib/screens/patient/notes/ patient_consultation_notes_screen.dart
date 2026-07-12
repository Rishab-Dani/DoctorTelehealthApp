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

            _buildCard(
              Icons.local_hospital,
              "Diagnosis",
              appointment.diagnosis,
            ),

            _buildCard(
              Icons.receipt_long,
              "Prescription",
              appointment.prescription,
            ),

            _buildCard(
              Icons.medication,
              "Medicines",
              appointment.medicines,
            ),

            _buildCard(
              Icons.tips_and_updates,
              "Advice",
              appointment.advice,
            ),

            _buildCard(
              Icons.calendar_today,
              "Follow-up Date",
              appointment.followUpDate == null
                  ? "-"
                  : DateTimeFormatter.formatDate(
                appointment.followUpDate!,
              ),
            ),

            _buildCard(
              Icons.note_alt,
              "Doctor Remarks",
              appointment.remarks,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      IconData icon,
      String title,
      String value,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Icon(
              icon,
              color: Colors.blue,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    value.isEmpty ? "-" : value,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}