import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/appointment.dart';
import '../../../services/firestore_service.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _reasonController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();

  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadPatient();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> loadPatient() async {
    final patient = await firestoreService.getCurrentPatient();

    _nameController.text = patient.name;
    _ageController.text = patient.age.toString();
    _phoneController.text = patient.phone;

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> bookAppointment() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select appointment date and time"),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    final appointmentDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    final appointment = Appointment(
      id: "",
      roomId: "",
      patientId: FirebaseAuth.instance.currentUser!.uid,
      patientName: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      phone: _phoneController.text.trim(),
      doctorId: "doctor001",
      doctorName: "Dr. Rishi",
      reason: _reasonController.text.trim(),
      status: "Pending",
      appointmentTime: appointmentDateTime,
      createdAt: DateTime.now(),
      diagnosis: "",
      prescription: "",
      medicines: "",
      advice: "",
      remarks: "",
      followUpDate: null,
    );

    try {
      await firestoreService.bookAppointment(appointment: appointment);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Appointment Booked Successfully"),
          backgroundColor: Colors.green,
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst("Exception: ", "")),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  InputDecoration decoration(
      String hint,
      IconData icon,
      ) {
    return InputDecoration(
      hintText: hint,

      prefixIcon: Icon(
        icon,
        color: Colors.blue,
      ),

      filled: true,
      fillColor: Colors.blue.shade50,

      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 20,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.blue.shade100,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(title: const Text("Book Appointment"), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.medical_services, color: Colors.white, size: 40),

                    SizedBox(height: 15),

                    Text(
                      "Book Your Appointment",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "Schedule a consultation with your doctor.",
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Card(
                elevation: 8,
                shadowColor: Colors.blue.withValues(alpha:.12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(22),

                  child: Column(
                    children: [

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Patient Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Patient Name
                      TextFormField(
                        controller: _nameController,
                        decoration: decoration(
                          "Patient Name",
                          Icons.person,
                        ),
                        validator: (v) =>
                        v!.isEmpty ? "Enter patient name" : null,
                      ),

                      const SizedBox(height: 18),

                      // Age
                      TextFormField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: decoration(
                          "Age",
                          Icons.cake,
                        ),
                        validator: (v) =>
                        v!.isEmpty ? "Enter age" : null,
                      ),

                      const SizedBox(height: 18),

                      // Phone
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: decoration(
                          "Phone Number",
                          Icons.phone,
                        ),
                        validator: (v) =>
                        v!.isEmpty ? "Enter phone number" : null,
                      ),

                      const SizedBox(height: 18),

                      // Date
                      ListTile(
                        tileColor: Colors.blue.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        leading: const Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        title: Text(
                          selectedDate == null
                              ? "Select Appointment Date"
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 18,
                        ),
                        onTap: selectDate,
                      ),

                      const SizedBox(height: 18),

                      // Time
                      ListTile(
                        tileColor: Colors.blue.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        leading: const Icon(
                          Icons.access_time,
                          color: Colors.blue,
                        ),
                        title: Text(
                          selectedTime == null
                              ? "Select Appointment Time"
                              : selectedTime!.format(context),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 18,
                        ),
                        onTap: selectTime,
                      ),

                      const SizedBox(height: 18),

                      // Reason
                      TextFormField(
                        controller: _reasonController,
                        maxLines: 4,
                        decoration: decoration(
                          "Reason for consultation",
                          Icons.medical_information,
                        ),
                        validator: (v) =>
                        v!.isEmpty ? "Enter reason" : null,
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.calendar_month),
                          label: loading
                              ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : const Text(
                            "Book Appointment",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: loading
                              ? null
                              : bookAppointment,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
