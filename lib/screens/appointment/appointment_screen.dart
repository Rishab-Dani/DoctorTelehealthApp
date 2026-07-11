import 'package:flutter/material.dart';

import '../ video_call/video_call_screen.dart';
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

              // video call button
              // onVideoCall: () {
              //   Navigator.push(
              //
              //     context,
              //
              //     MaterialPageRoute(
              //
              //       builder: (_)=>VideoCallScreen(
              //
              //         userId: appointment.patientId,
              //
              //         userName: appointment.patientName,
              //
              //         callId: appointment.id,
              //
              //       ),
              //
              //     ),
              //
              //   );
              //
              // },

              onVideoCall: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VideoCallScreen(
                      userId: "doctor_001",
                      userName: "Dr. Rishi",
                      callId: appointment.id,
                    ),
                  ),
                );
              },

              onCancel: () {

                ScaffoldMessenger.of(context).showSnackBar(

                  const SnackBar(
                    content:
                    Text("Appointment Cancelled"),
                  ),

                );

              },

              // session note button
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