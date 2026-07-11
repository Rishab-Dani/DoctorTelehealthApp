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
            ? Colors.green.shade50
            : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color:
          confirmed ? Colors.green : Colors.orange,
        ),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            confirmed
                ? Icons.check_circle
                : Icons.schedule,
            color:
            confirmed ? Colors.green : Colors.orange,
          ),

          const SizedBox(width: 8),

          Text(
            status,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
              confirmed ? Colors.green : Colors.orange,
            ),
          ),

        ],
      ),
    );
  }
}