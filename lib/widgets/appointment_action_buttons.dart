import 'package:flutter/material.dart';

class AppointmentActionButtons extends StatelessWidget {

  final bool confirmed;

  final VoidCallback onVideoCall;

  final VoidCallback onCancel;

  final VoidCallback onNotes;

  const AppointmentActionButtons({

    super.key,

    required this.confirmed,

    required this.onVideoCall,

    required this.onCancel,

    required this.onNotes,

  });

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        SizedBox(

          width: double.infinity,

          child: ElevatedButton.icon(

            icon: Icon(
              confirmed
                  ? Icons.video_call
                  : Icons.cancel,
            ),

            label: Text(
              confirmed
                  ? "Start Video Call"
                  : "Cancel Appointment",
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor:
              confirmed ? Colors.green : Colors.red,
              foregroundColor: Colors.white,
            ),

            onPressed:
            confirmed ? onVideoCall : onCancel,

          ),

        ),

        const SizedBox(height: 12),

        SizedBox(

          width: double.infinity,

          child: OutlinedButton.icon(

            icon: const Icon(Icons.note_alt),

            label: const Text("Session Notes"),

            onPressed: onNotes,

          ),

        )

      ],
    );
  }
}