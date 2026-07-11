import 'package:flutter/material.dart';

import '../../../models/appointment.dart';
//import '../../video_call/video_call_screen.dart';
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

                    ListTile(

                      contentPadding:
                      EdgeInsets.zero,

                      leading:
                      const Icon(Icons.calendar_today),

                      title: Text(
                        appointment.appointmentTime
                            .toString(),
                      ),
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

            // SizedBox(
            //
            //   width: double.infinity,
            //
            //   child: ElevatedButton.icon(
            //
            //     icon: const Icon(Icons.video_call),
            //
            //     label: Text(
            //       canJoin
            //           ? "Join Consultation"
            //           : "Waiting for Doctor",
            //     ),
            //
            //     onPressed: canJoin
            //         ? () {
            //
            //       Navigator.push(
            //
            //         context,
            //
            //         MaterialPageRoute(
            //
            //           builder: (_) =>
            //               VideoCallScreen(
            //                 appointment:
            //                 appointment,
            //               ),
            //
            //         ),
            //
            //       );
            //
            //     }
            //         : null,
            //   ),
            // ),

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