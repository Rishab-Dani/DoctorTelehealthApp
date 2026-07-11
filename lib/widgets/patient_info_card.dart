import 'package:flutter/material.dart';
import '../models/appointment.dart';
import 'package:intl/intl.dart';

class PatientInfoCard extends StatelessWidget {
  final Appointment appointment;

  const PatientInfoCard({
    super.key,
    required this.appointment,
  });

  Widget buildTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Patient Details",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Divider(),

            buildTile(
              Icons.person,
              appointment.patientName,
              "Patient Name",
            ),

            buildTile(
              Icons.badge,
              appointment.patientId,
              "Patient ID",
            ),

            buildTile(
              Icons.cake,
              "${appointment.age} Years",
              "Age",
            ),

            buildTile(
              Icons.phone,
              appointment.phone,
              "Phone Number",
            ),

            buildTile(
              Icons.schedule,
              DateFormat("dd MMM yyyy hh:mm a")
                  .format(appointment.appointmentTime),
              "Appointment Time",
            ),
          ],
        ),
      ),
    );
  }
}