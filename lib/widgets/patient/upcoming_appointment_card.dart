import 'package:flutter/material.dart';

import '../../models/appointment.dart';

class UpcomingAppointmentCard extends StatelessWidget {

  final Appointment appointment;

  const UpcomingAppointmentCard({
    super.key,
    required this.appointment,
  });

  Color get statusColor {

    switch (appointment.status.toLowerCase()) {

      case "confirmed":
        return Colors.green;

      case "pending":
        return Colors.orange;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withOpacity(.05),

            blurRadius: 12,

            offset: const Offset(0, 6),

          ),

        ],

      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          const Text(

            "Upcoming Appointment",

            style: TextStyle(

              fontSize: 20,

              fontWeight: FontWeight.bold,

            ),

          ),

          const SizedBox(height: 18),

          Text(

            appointment.doctorName,

            style: const TextStyle(

              fontSize: 18,

              fontWeight: FontWeight.bold,

            ),

          ),

          const SizedBox(height: 8),

          Text(

            appointment.reason,

            style: TextStyle(

              color: Colors.grey.shade700,

            ),

          ),

          const SizedBox(height: 15),

          Chip(

            backgroundColor:
            statusColor.withOpacity(.15),

            label: Text(

              appointment.status,

              style: TextStyle(

                color: statusColor,

                fontWeight: FontWeight.bold,

              ),

            ),

          ),
        ],
      ),
    );
  }
}