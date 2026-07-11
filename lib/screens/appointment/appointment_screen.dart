import 'package:flutter/material.dart';

import '../../models/appointment.dart';
import '../../widgets/appointment_action_buttons.dart';
import '../../widgets/appointment_status_chip.dart';
import '../../widgets/patient_info_card.dart';
import '../notes/notes_screen.dart';

class AppointmentScreen extends StatelessWidget {

  final Appointment appointment;

  const AppointmentScreen({

    super.key,

    required this.appointment,

  });

  @override
  Widget build(BuildContext context) {

    bool isConfirmed =
        appointment.status.toLowerCase() == "confirmed";

    return Scaffold(

      appBar: AppBar(
        title: const Text("Appointment"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            PatientInfoCard(
              appointment: appointment,
            ),

            const SizedBox(height: 20),

            AppointmentStatusChip(
              status: appointment.status,
            ),

            const Spacer(),

            AppointmentActionButtons(

              confirmed:
              appointment.status.toLowerCase() ==
                  "confirmed",

              onVideoCall: () {

                // Next Phase

              },

              onCancel: () {

                ScaffoldMessenger.of(context).showSnackBar(

                  const SnackBar(
                    content:
                    Text("Appointment Cancelled"),
                  ),

                );

              },

              onNotes: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NotesScreen(
                      appointmentId: appointment.id,
                    ),
                  ),
                );

              },

            ),

          ],

        ),

      ),
    );
  }
}