import 'package:flutter/material.dart';
import '../appointment/appointment_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Doctor Dashboard"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            Card(
              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: ListTile(
                leading: const CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.person),
                ),

                title: const Text(
                  "Dr. Rishi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text("General Physician"),

                trailing: const Icon(Icons.notifications),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(Icons.calendar_today),

                label: const Text("Today's Appointment"),

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(18),
                ),

                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AppointmentScreen(),
                    ),
                  );

                },

              ),
            )

          ],
        ),
      ),
    );
  }
}