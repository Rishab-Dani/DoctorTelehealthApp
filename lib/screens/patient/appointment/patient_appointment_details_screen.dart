import 'package:flutter/material.dart';

import '../../../core/utils/date_time_formatter.dart';
import '../../../models/appointment.dart';
import '../../../services/video_call_service.dart';
import '../../video_call/video_call_screen.dart';
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
                  canJoin
                      ? "Join Consultation"
                      : "Waiting for Doctor",
                ),

                onPressed: () {

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

                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(

              width: double.infinity,

              child: OutlinedButton.icon(
                icon: const Icon(Icons.notes),
                label: const Text("Consultation Notes"),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Consultation Notes - Coming Soon",
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}