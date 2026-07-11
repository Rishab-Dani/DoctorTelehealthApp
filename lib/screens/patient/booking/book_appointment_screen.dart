import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/appointment.dart';
import '../../../services/firestore_service.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() =>
      _BookAppointmentScreenState();
}

// Future<void> loadPatient() async {
//
//   patient =
//   await firestoreService.getCurrentPatient();
//
//   _nameController.text = patient!.name;
//
//   _phoneController.text = patient!.phone;
//
//   _ageController.text =
//       patient!.age.toString();
//
//   setState(() {});
// }

class _BookAppointmentScreenState
    extends State<BookAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _reasonController = TextEditingController();

  final FirestoreService firestoreService =
  FirestoreService();

  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  bool loading = false;

  // @override
  // void initState() {
  //   super.initState();
  //   loadPatient();
  // }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _reasonController.dispose();
    super.dispose();
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
          content: Text(
            "Please select appointment date and time",
          ),
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
      patientId:
      FirebaseAuth.instance.currentUser!.uid,
      patientName: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      phone: _phoneController.text.trim(),
      doctorId: "doctor001",
      doctorName: "Dr. Rishi",
      reason: _reasonController.text.trim(),
      status: "Pending",
      appointmentTime: appointmentDateTime,
      createdAt: DateTime.now(),
    );

    try {
      await firestoreService.bookAppointment(
        appointment: appointment,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Appointment booked successfully",
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
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
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xffF5F7FB),

      appBar: AppBar(
        title: const Text("Book Appointment"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              TextFormField(
                controller: _nameController,
                decoration: decoration(
                  "Patient Name",
                  Icons.person,
                ),
                validator: (v) =>
                v!.isEmpty
                    ? "Enter patient name"
                    : null,
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller: _ageController,
                keyboardType:
                TextInputType.number,
                decoration: decoration(
                  "Age",
                  Icons.cake,
                ),
                validator: (v) =>
                v!.isEmpty
                    ? "Enter age"
                    : null,
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller: _phoneController,
                keyboardType:
                TextInputType.phone,
                decoration: decoration(
                  "Phone Number",
                  Icons.phone,
                ),
                validator: (v) =>
                v!.isEmpty
                    ? "Enter phone number"
                    : null,
              ),

              const SizedBox(height: 18),

              ListTile(
                tileColor:
                Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                      16),
                ),
                leading:
                const Icon(Icons.date_range),
                title: Text(
                  selectedDate == null
                      ? "Select Date"
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                ),
                onTap: selectDate,
              ),

              const SizedBox(height: 18),

              ListTile(
                tileColor:
                Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                      16),
                ),
                leading:
                const Icon(Icons.access_time),
                title: Text(
                  selectedTime == null
                      ? "Select Time"
                      : selectedTime!
                      .format(context),
                ),
                onTap: selectTime,
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller:
                _reasonController,
                maxLines: 4,
                decoration: decoration(
                  "Reason for consultation",
                  Icons.medical_information,
                ),
                validator: (v) =>
                v!.isEmpty
                    ? "Enter reason"
                    : null,
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 56,

                child: ElevatedButton(
                  onPressed: loading
                      ? null
                      : bookAppointment,

                  child: loading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    "Book Appointment",
                    style: TextStyle(
                      fontSize: 18,
                    ),
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