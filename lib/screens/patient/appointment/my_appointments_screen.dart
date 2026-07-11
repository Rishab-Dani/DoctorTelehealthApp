import 'package:doctor_telehealth_app/screens/patient/appointment/patient_appointment_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/appointment.dart';
import '../../../providers/appointment_provider.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("My Appointments"),
      ),

      body: StreamBuilder<List<Appointment>>(

        stream: context
            .read<AppointmentProvider>()
            .patientAppointments,

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );

          }

          if (snapshot.hasError) {

            return Center(
              child: Text(snapshot.error.toString()),
            );

          }

          final appointments =
              snapshot.data ?? [];

          if (appointments.isEmpty) {

            return const Center(
              child: Text(
                "No appointments found",
              ),
            );

          }

          return ListView.builder(

            padding: const EdgeInsets.all(16),

            itemCount: appointments.length,

            itemBuilder: (context, index) {

              final appointment =
              appointments[index];

              return InkWell(

                  borderRadius:
                  BorderRadius.circular(16),

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            PatientAppointmentDetailsScreen(

                              appointment: appointment,

                            ),

                      ),

                    );

                  },

                  child: Card(

                margin:
                const EdgeInsets.only(
                  bottom: 16,
                ),

                child: ListTile(

                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),

                  title: Text(
                    appointment.doctorName,
                  ),

                  subtitle: Text(
                    appointment.reason,
                  ),

                  trailing: Chip(
                    label: Text(
                      appointment.status,
                    ),
                  ),
                ),
               ),
              );
            },
          );
        },
      ),
    );
  }
}