import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/date_time_formatter.dart';
import '../../models/appointment.dart';
import '../../providers/appointment_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../appointment/appointment_screen.dart';
import '../login/login_screen.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});
  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshDashboard() async {
    setState(() {});
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          "Logout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sure you want to logout?",
        ),
        actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        actions: [

          Row(
            children: [

              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (!mounted) return;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                          (route) => false,
                    );
                  },
                  child: const Text("Logout"),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = context.watch<DashboardProvider>();

    return Scaffold(
      backgroundColor: const Color(0xffF5F8FD),

      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Doctor Dashboard",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: _refreshDashboard,

        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),

          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              //----------------------------------
              // Header
              //----------------------------------
              Container(
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),

                  gradient: const LinearGradient(
                    colors: [Color(0xff2F80ED), Color(0xff4F8DFF)],

                    begin: Alignment.topLeft,

                    end: Alignment.bottomRight,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha:.25),

                      blurRadius: 15,

                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            DateTime.now().hour < 12
                                ? "Good Morning 👋"
                                : DateTime.now().hour < 17
                                ? "Good Afternoon ☀️"
                                : "Good Evening 🌙",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            "Dr. Doctor",

                            style: TextStyle(
                              color: Colors.white,

                              fontWeight: FontWeight.bold,

                              fontSize: 32,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: const [
                              Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 18,
                              ),

                              SizedBox(width: 6),

                              Text(
                                "General Physician",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white24,

                              borderRadius: BorderRadius.circular(30),
                            ),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,

                              children: const [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.greenAccent,
                                ),

                                SizedBox(width: 8),

                                Text(
                                  "Available",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 130,
                      width: 130,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha:0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Center(
                child: Text(
                  "Summary",

                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  Expanded(
                    child: _summaryCard(
                      title: "Appointments",

                      value: StreamBuilder<int>(
                        stream: dashboard.appointmentCount(),
                        builder: (context, snapshot) {
                          return Text(
                          "${snapshot.data ?? 0}",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),

                      color: Colors.blue,

                      icon: Icons.calendar_month,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: _summaryCard(
                      title: "Notes",

                      value: StreamBuilder<int>(
                        stream: dashboard.noteCount(),
                        builder: (context, snapshot) {
                          return Text(
                            "${snapshot.data ?? 0}",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),

                      color: Colors.orange,

                      icon: Icons.note_alt,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              const Center(
                child: Text(
                  "Appointments",

                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),

              const SizedBox(height: 20),

              // PART 2
              StreamBuilder<List<Appointment>>(
                stream: context.read<AppointmentProvider>().appointments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: CircularProgressIndicator()),
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

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.event_busy, size: 70, color: Colors.grey),
                          SizedBox(height: 15),
                          Text(
                            "No Appointments Today",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final appointments = snapshot.data!;

                  return ListView.builder(
                    itemCount: appointments.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final appointment = appointments[index];

                      return InkWell(
                        borderRadius: BorderRadius.circular(22),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AppointmentScreen(appointment: appointment),
                            ),
                          );
                        },

                        child: Container(
                          margin: const EdgeInsets.only(bottom: 18),

                          padding: const EdgeInsets.all(18),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(22),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha:.05),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),

                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Container(
                                    height: 65,

                                    width: 65,

                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,

                                      shape: BoxShape.circle,
                                    ),

                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                      size: 34,
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          appointment.patientName,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 5),

                                        Text(
                                          "Patient ID : ${shortText(appointment.patientId, 8)}",
                                        ),

                                        const SizedBox(height: 14),

                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              color: Colors.blue.shade700,
                                              size: 16,
                                            ),

                                            const SizedBox(width: 6),

                                            Text(
                                              DateTimeFormatter.formatDate(
                                                appointment.appointmentTime,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 10),

                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: Colors.blue.shade700,
                                              size: 16,
                                            ),

                                            const SizedBox(width: 6),

                                            Text(
                                              DateTimeFormatter.formatTime(
                                                appointment.appointmentTime,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 12),

                                        Row(
                                          children: [
                                            Icon(
                                              Icons.medical_services,
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
                                      _statusChip(appointment.status),

                                      const SizedBox(height: 30),

                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),

                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),

                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,

                                          children: [
                                            Text(
                                              "View",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            SizedBox(width: 6),

                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 13,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required Widget value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: color.withValues(alpha:.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: color, size: 30),
          ),

          const SizedBox(height: 18),

          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            child: value,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    Color bg;
    Color text;
    IconData icon;

    switch (status.toLowerCase()) {
      case "confirmed":
        bg = Colors.green.shade100;
        text = Colors.green.shade700;
        icon = Icons.check_circle;
        break;

      case "completed":
        bg = Colors.blue.shade100;
        text = Colors.blue.shade700;
        icon = Icons.task_alt;
        break;

      case "cancelled":
        bg = Colors.red.shade100;
        text = Colors.red.shade700;
        icon = Icons.cancel;
        break;

      default:
        bg = Colors.orange.shade100;
        text = Colors.orange.shade700;
        icon = Icons.schedule;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: text),

          const SizedBox(width: 6),

          Text(
            status.toUpperCase(),
            style: TextStyle(
              color: text,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // patient's appointment
  String shortText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return text.substring(0, maxLength);
  }
}
