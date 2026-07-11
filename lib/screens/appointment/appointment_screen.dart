import 'package:flutter/material.dart';

import '../notes/notes_screen.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    bool isConfirmed = true;

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

                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("John David"),
                  subtitle: Text("Patient Name"),
                ),

                const ListTile(
                  leading: Icon(Icons.badge),
                  title: Text("PID1001"),
                  subtitle: Text("Patient ID"),
                ),

                const ListTile(
                  leading: Icon(Icons.cake),
                  title: Text("30 Years"),
                  subtitle: Text("Age"),
                ),

                const ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("9876543210"),
                  subtitle: Text("Phone"),
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