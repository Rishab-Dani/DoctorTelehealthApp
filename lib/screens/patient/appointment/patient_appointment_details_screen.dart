import 'package:flutter/material.dart';

import '../../../core/utils/date_time_formatter.dart';
import '../../../models/appointment.dart';
import '../../../services/video_call_service.dart';
import '../../video_call/video_call_screen.dart';
import '../notes/patient_consultation_notes_screen.dart';
//import '../notes/patient_notes_screen.dart';

class PatientAppointmentDetailsScreen extends StatelessWidget {
  final Appointment appointment;

  const PatientAppointmentDetailsScreen({super.key, required this.appointment});

  bool get canJoin => appointment.status.toLowerCase() == "confirmed";

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
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_hospital,
                          color: Colors.blue,
                          size: 32,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.doctorName,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              "General Physician",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  _buildInfoRow(
                    Icons.calendar_today,
                    DateTimeFormatter.formatDate(appointment.appointmentTime),
                  ),

                  const SizedBox(height: 15),

                  _buildInfoRow(
                    Icons.access_time,
                    DateTimeFormatter.formatTime(appointment.appointmentTime),
                  ),

                  const SizedBox(height: 15),

                  _buildInfoRow(Icons.medical_services, appointment.reason),

                  const SizedBox(height: 18),

                  _buildStatusChip(),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: appointment.status.toLowerCase() == "confirmed"
                    ? const LinearGradient(
                        colors: [Color(0xff3B82F6), Color(0xff2563EB)],
                      )
                    : null,
                color: appointment.status.toLowerCase() == "confirmed"
                    ? null
                    : Colors.grey.shade300,
                boxShadow: appointment.status.toLowerCase() == "confirmed"
                    ? [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha:.30),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : [],
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                icon: Icon(
                  appointment.status.toLowerCase() == "completed"
                      ? Icons.check_circle
                      : Icons.video_call_rounded,
                  color: Colors.white,
                ),
                label: Text(
                  appointment.status.toLowerCase() == "completed"
                      ? "Consultation Finished"
                      : canJoin
                      ? "Join Consultation"
                      : "Waiting for Doctor",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 18),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green.shade700),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        "This consultation has been completed successfully.",
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: appointment.status.toLowerCase() == "completed"
                  ? Container(
                      width: double.infinity,
                      height: 58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.blue.shade300),
                      ),
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
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
                        icon: const Icon(
                          Icons.description_outlined,
                          color: Colors.blue,
                        ),
                        label: const Text(
                          "View Consultation Notes",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  : Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.orange.shade200,
                  ),
                ),
                child: Column(
                  children: [

                    Icon(
                      Icons.schedule,
                      color: Colors.orange.shade700,
                      size: 42,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Consultation Notes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.orange.shade700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Consultation notes will be available after the doctor completes your consultation.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blue, size: 20),
        ),

        const SizedBox(width: 14),

        Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
      ],
    );
  }

  Widget _buildStatusChip() {
    Color color;

    switch (appointment.status.toLowerCase()) {
      case "confirmed":
        color = Colors.green;
        break;

      case "pending":
        color = Colors.orange;
        break;

      case "completed":
        color = Colors.blue;
        break;

      case "cancelled":
        color = Colors.red;
        break;

      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha:.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        appointment.status,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
