import 'package:flutter/material.dart';

import '../../../core/utils/date_time_formatter.dart';
import '../../../models/appointment.dart';
import '../../../services/video_call_service.dart';
import '../../video_call/video_call_screen.dart';
import '../notes/ patient_consultation_notes_screen.dart';
//import '../notes/patient_notes_screen.dart';

class PatientAppointmentDetailsScreen extends StatelessWidget {

  final Appointment appointment;

  const PatientAppointmentDetailsScreen({
    super.key,
    required this.appointment,
  });

  bool get canJoin =>
      appointment.status.toLowerCase() == "confirmed";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        title: const Text("Appointment Details"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Card(

              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20),
              ),

              child: Padding(

                padding: const EdgeInsets.all(20),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      appointment.doctorName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [

                            const Icon(Icons.calendar_today),

                            const SizedBox(width: 10),

                            Text(
                              DateTimeFormatter.formatDate(
                                appointment.appointmentTime,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [

                            const Icon(Icons.access_time),

                            const SizedBox(width: 10),

                            Text(
                              DateTimeFormatter.formatTime(
                                appointment.appointmentTime,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    ListTile(

                      contentPadding:
                      EdgeInsets.zero,

                      leading:
                      const Icon(Icons.medical_information),

                      title: Text(
                        appointment.reason,
                      ),
                    ),

                    ListTile(

                      contentPadding:
                      EdgeInsets.zero,

                      leading:
                      const Icon(Icons.flag),

                      title: Text(
                        appointment.status,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(Icons.video_call),

                label: Text(
                  appointment.status.toLowerCase() == "completed"
                      ? "Consultation Finished"
                      : canJoin
                      ? "Join Consultation"
                      : "Waiting for Doctor",
                ),

                onPressed: canJoin
                    ? () {

                  final callId = appointment.roomId;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoCallScreen(
                        userId: VideoCallService.getUserId(),
                        userName: appointment.patientName,
                        callId: callId,
                      ),
                    ),
                  );

                }
                    : null,
              ),
            ),

            if (appointment.status.toLowerCase() == "completed")
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  "This consultation has been completed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            SizedBox(

              width: double.infinity,

              child: appointment.status.toLowerCase() == "completed"
                  ? OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PatientConsultationNotesScreen(
                        appointment: appointment,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.notes),
                label: const Text("Consultation Notes"),
              )
                  : Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange),
                ),
                child: const Text(
                  "Consultation notes will be available after the doctor completes the consultation.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}