import 'package:flutter/material.dart';

import '../ video_call/video_call_screen.dart';
import '../../models/appointment.dart';
import '../../services/video_call_service.dart';
import '../../widgets/appointment/appointment_status_chip.dart';
import '../../widgets/appointment/appointment_summary_card.dart';
import '../../widgets/appointment/session_notes_card.dart';
import '../../widgets/appointment/video_consultation_card.dart';
import '../../widgets/dashboard/patient_info_card.dart';
import '../notes/notes_screen.dart';

class AppointmentScreen extends StatelessWidget {
  final Appointment appointment;

  const AppointmentScreen({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F6FB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: const Text(
          "Appointment Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              PatientInfoCard(
                appointment: appointment,
              ),

              const SizedBox(height: 20),

              AppointmentSummaryCard(
                appointment: appointment,
              ),

              const SizedBox(height: 20),

              VideoConsultationCard(
                onStartCall: () async {

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  await Future.delayed(
                    const Duration(milliseconds: 600),
                  );

                  if (!context.mounted) return;

                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoCallScreen(
                        userId: VideoCallService.getUserId(),
                        userName: VideoCallService.getUserName(),
                        callId: VideoCallService.generateCallId(
                          appointment.id,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              SessionNotesCard(
                onTap: () {
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

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Cancel Appointment",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    side: BorderSide(
                      color: Colors.red.shade200,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Appointment Cancelled",
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}