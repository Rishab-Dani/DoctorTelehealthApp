import 'package:flutter/material.dart';

class AppointmentStatusChip extends StatelessWidget {
  final String status;

  const AppointmentStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {

    final confirmed =
        status.toLowerCase() == "confirmed";

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: confirmed
            ? Colors.green.shade100
            : Colors.orange.shade100,
        borderRadius: BorderRadius.circular(30),
      ),

      child: Text(
        "Status : $status",
        style: TextStyle(
          color:
          confirmed ? Colors.green : Colors.orange,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}