import 'package:flutter/material.dart';
import 'dashboard_stat_card.dart';

class DashboardStatistics extends StatelessWidget {
  final int appointments;
  final int notes;

  const DashboardStatistics({
    super.key,
    required this.appointments,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DashboardStatCard(
          title: "Appointments",
          value: appointments.toString(),
          icon: Icons.calendar_today,
          color: Colors.blue,
        ),

        const SizedBox(width:20),

        DashboardStatCard(
          title: "Notes",
          value: notes.toString(),
          icon: Icons.note_alt,
          color: Colors.orange,
        ),
      ],
    );
  }
}