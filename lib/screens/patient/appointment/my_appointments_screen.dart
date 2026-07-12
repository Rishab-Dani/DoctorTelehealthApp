import 'package:doctor_telehealth_app/screens/patient/appointment/patient_appointment_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/appointment.dart';
import '../../../providers/appointment_provider.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  /// status information
  Widget buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (status.toLowerCase()) {
      case "confirmed":
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        icon = Icons.check_circle;
        break;

      case "completed":
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        icon = Icons.task_alt;
        break;

      case "cancelled":
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        icon = Icons.cancel;
        break;

      default:
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        icon = Icons.schedule;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: textColor,
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "My Appointments",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
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
                  elevation: 6,
                  shadowColor: Colors.blue.withValues(alpha:.08),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),

                  margin: const EdgeInsets.only(bottom: 18),

                  child: Padding(
                    padding: const EdgeInsets.all(18),

                    child: Column(
                      children: [

                        Row(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.blue.shade50,
                              child: Icon(
                                Icons.medical_services,
                                color: Colors.blue.shade700,
                                size: 30,
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                  Text(
                                    appointment.doctorName,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "General Physician",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),

                                  const SizedBox(height: 15),

                                  Row(
                                    children: [

                                      Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: Colors.blue.shade700,
                                      ),

                                      const SizedBox(width: 8),

                                      Text(
                                        "${appointment.appointmentTime.day}/${appointment.appointmentTime.month}/${appointment.appointmentTime.year}",
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    children: [

                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: Colors.blue.shade700,
                                      ),

                                      const SizedBox(width: 8),

                                      Text(
                                        TimeOfDay.fromDateTime(
                                          appointment.appointmentTime,
                                        ).format(context),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 15),

                                  Row(
                                    children: [

                                      Icon(
                                        Icons.medical_information,
                                        color: Colors.blue.shade700,
                                        size: 18,
                                      ),

                                      const SizedBox(width: 8),

                                      Expanded(
                                        child: Text(
                                          appointment.reason,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                buildStatusChip(
                                  appointment.status,
                                ),

                                const SizedBox(height: 18),

                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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