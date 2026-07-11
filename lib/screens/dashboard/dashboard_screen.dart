import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/appointment.dart';
import '../../providers/appointment_provider.dart';
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

            // doctor card
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

            const Text(
              "Today's Appointments",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: StreamBuilder<List<Appointment>>(
                stream: context.read<AppointmentProvider>().appointments,

                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No appointments found"),
                    );
                  }

                  final appointments = snapshot.data!;

                  return ListView.builder(

                    itemCount: appointments.length,

                    itemBuilder: (context, index) {

                      final appointment = appointments[index];

                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),

                          title: Text(
                            appointment.patientName,
                          ),

                          subtitle: Text(
                            appointment.patientId,
                          ),

                          trailing: Container(

                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),

                            decoration: BoxDecoration(
                              color: appointment.status == "Confirmed"
                                  ? Colors.green.shade100
                                  : Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Text(
                              appointment.status,
                            ),

                          ),

                          onTap: () {

                            Navigator.push(

                              context,

                              MaterialPageRoute(

                                builder: (_) => AppointmentScreen(
                                  appointment: appointment,
                                ),

                              ),

                            );

                          },
                        ),
                      );

                    },

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