import 'package:flutter/material.dart';

import '../../services/firestore_service.dart';
import '../video_call/video_call_screen.dart';
import '../../models/appointment.dart';
import '../../services/video_call_service.dart';
import '../../widgets/appointment/appointment_summary_card.dart';
import '../../widgets/appointment/session_notes_card.dart';
import '../../widgets/appointment/video_consultation_card.dart';
import '../../widgets/dashboard/patient_info_card.dart';
import '../notes/notes_screen.dart';

class AppointmentScreen extends StatelessWidget {
  final Appointment appointment;
  final FirestoreService firestoreService = FirestoreService();

  late final status = appointment.status.toLowerCase();

  late final isCompleted = status == "completed";
  late final isCancelled = status == "cancelled";

  late final canModify = !(isCompleted || isCancelled);

   AppointmentScreen({
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

              if (isCompleted)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        "Consultation Completed",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

              if (isCancelled)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        "Appointment Cancelled",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
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

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle),
                  label: const Text(
                    "Complete Consultation",
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await firestoreService.completeAppointment(appointment.id);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Consultation completed successfully"),
                        ),
                      );

                      Navigator.pop(context);

                    } catch (e) {

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString().replaceFirst("Exception: ", "")),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 20),

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
                  onPressed: () async {
                    try {
                      await firestoreService.cancelAppointment(appointment.id);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Appointment canceled successfully"),
                        ),
                      );

                      Navigator.pop(context);

                    } catch (e) {

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString().replaceFirst("Exception: ", "")),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}