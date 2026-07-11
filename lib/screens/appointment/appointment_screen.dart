import 'package:flutter/material.dart';

import '../../models/appointment.dart';
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
        appointment.status == "Confirmed";

    return Scaffold(

      appBar: AppBar(
        title: const Text("Appointment"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Card(

          elevation: 5,

          child: Padding(

            padding: const EdgeInsets.all(16),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const Text(
                  "Patient Details",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(appointment.patientName),
                  subtitle: const Text("Patient Name"),
                ),

                ListTile(
                  leading: const Icon(Icons.badge),
                  title: Text(appointment.patientId),
                  subtitle: const Text("Patient ID"),
                ),

                ListTile(
                  leading: const Icon(Icons.cake),
                  title: Text("${appointment.age} Years"),
                  subtitle: const Text("Age"),
                ),

                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(appointment.phone),
                  subtitle: const Text("Phone"),
                ),

                const ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text("11 July 2026 11:30 AM"),
                  subtitle: Text("Appointment"),
                ),

                const SizedBox(height: 15),

                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isConfirmed
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    isConfirmed
                        ? "Status : Confirmed"
                        : "Status : Unconfirmed",
                  ),
                ),

                const Spacer(),

                // video call button
                SizedBox(

                  width: double.infinity,

                  child: ElevatedButton.icon(

                    icon: Icon(
                      isConfirmed
                          ? Icons.video_call
                          : Icons.cancel,
                    ),

                    label: Text(
                      isConfirmed
                          ? "Start Video Call"
                          : "Cancel Appointment",
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      isConfirmed ? Colors.green : Colors.red,
                      foregroundColor: Colors.white,
                    ),

                    onPressed: () {

                    },

                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.note_alt),
                    label: const Text("Session Notes"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotesScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}