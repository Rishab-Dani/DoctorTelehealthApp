import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/appointment.dart';
import '../../providers/appointment_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../widgets/dashboard/dashboard_header.dart';
import '../../widgets/dashboard/summary_card.dart';
import '../../widgets/appointment/appointment_preview_card.dart';
import '../appointment/appointment_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F6FB),

      body: SafeArea(
        child: Column(
          children: [
            /// Scrollable top section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    DashboardHeader(
                      doctorName: user?.email?.split("@").first ?? "Doctor",
                    ),

                    const SizedBox(height: 25),

                    /// Summary Title
                    const Center(
                      child: Text(
                        "Today's Summary",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Summary Cards
                    Row(
                      children: [
                        Expanded(
                          child: StreamBuilder<int>(
                            stream: DashboardProvider().appointmentCount(),
                            builder: (context, snapshot) {
                              return SummaryCard(
                                title: "Appointments",
                                value: "${snapshot.data ?? 0}",
                                icon: Icons.calendar_today,
                                color: Colors.blue,
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: StreamBuilder<int>(
                            stream: DashboardProvider().noteCount(),
                            builder: (context, snapshot) {
                              return SummaryCard(
                                title: "Notes",
                                value: "${snapshot.data ?? 0}",
                                icon: Icons.edit_note,
                                color: Colors.orange,
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// Appointment Title
                    const Center(
                      child: Text(
                      "Today's Appointments",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),

                    const SizedBox(height: 15),

                    /// Appointment List
                    StreamBuilder<List<Appointment>>(
                      stream: context
                          .read<AppointmentProvider>()
                          .appointments,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              snapshot.error.toString(),
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Center(
                              child: Text(
                                "No Appointments Today",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          );
                        }

                        final appointments = snapshot.data!;

                        debugPrint(
                            "Appointments Count : ${appointments.length}");

                        return ListView.builder(
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemCount: appointments.length,
                          itemBuilder: (context, index) {
                            final appointment =
                            appointments[index];

                            debugPrint(
                                appointment.patientName);

                            return Padding(
                              padding:
                              const EdgeInsets.only(bottom: 12),
                              child: AppointmentPreviewCard(
                                patientName:
                                appointment.patientName,
                                patientId:
                                appointment.patientId,
                                status: appointment.status,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          AppointmentScreen(
                                            appointment:
                                            appointment,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}