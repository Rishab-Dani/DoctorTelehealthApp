import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/appointment.dart';
import '../../providers/appointment_provider.dart';
import '../../widgets/dashboard_header.dart';
import '../../widgets/dashboard_stat_card.dart';
import '../../widgets/dashboard_statistics.dart';
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
            const DashboardHeader(),

            const SizedBox(height: 20),

            // DashboardStatistics
            const DashboardStatistics(
              appointments: 1,
              notes: 1,
            ),

            const SizedBox(height: 25),

            // Today's appointments
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Today's Appointments",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
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