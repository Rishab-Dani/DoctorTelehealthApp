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

          height: 55,

          child: ElevatedButton.icon(

            icon: const Icon(Icons.video_call),

            label: const Text(
              "Start Video Consultation",
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            style: ElevatedButton.styleFrom(

              backgroundColor: Colors.green,

              foregroundColor: Colors.white,

              shape: RoundedRectangleBorder(

                borderRadius:
                BorderRadius.circular(14),

              ),

            ),

            onPressed: onVideoCall,

          ),

        ),

        const SizedBox(height: 12),

        SizedBox(

          width: double.infinity,

          height: 55,

          child: OutlinedButton.icon(

            icon: const Icon(Icons.note_alt),

            label: const Text(

              "Open Session Notes",

              style: TextStyle(
                fontSize: 18,
              ),

            ),

            style: OutlinedButton.styleFrom(

              shape: RoundedRectangleBorder(

                borderRadius:
                BorderRadius.circular(14),

              ),

            ),

            onPressed: onNotes,

          ),

        ),

      ],
    );
  }
}