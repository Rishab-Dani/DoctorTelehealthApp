import 'package:flutter/material.dart';

import '../../models/consultation_note.dart';
import '../../services/firestore_service.dart';

class ConsultationNotesScreen extends StatefulWidget {
  final String appointmentId;

  const ConsultationNotesScreen({
    super.key,
    required this.appointmentId,
  });

  @override
  State<ConsultationNotesScreen> createState() =>
      _ConsultationNotesScreenState();
}

class _ConsultationNotesScreenState
    extends State<ConsultationNotesScreen> {



  final diagnosisController = TextEditingController();

  final prescriptionController = TextEditingController();

  final medicinesController = TextEditingController();

  final adviceController = TextEditingController();

  final remarksController = TextEditingController();

  DateTime? followUpDate;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void dispose() {
    diagnosisController.dispose();
    prescriptionController.dispose();
    medicinesController.dispose();
    adviceController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  Future<void> pickFollowUpDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        followUpDate = picked;
      });
    }
  }

  bool validateFields() {
    if (diagnosisController.text.trim().isEmpty) return false;
    if (prescriptionController.text.trim().isEmpty) return false;
    if (medicinesController.text.trim().isEmpty) return false;
    if (adviceController.text.trim().isEmpty) return false;
    if (remarksController.text.trim().isEmpty) return false;
    if (followUpDate == null) return false;

    return true;
  }

  Future<void> saveConsultation() async {
    if (!validateFields()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }

    final note = ConsultationNote(
      diagnosis: diagnosisController.text.trim(),
      prescription: prescriptionController.text.trim(),
      medicines: medicinesController.text.trim(),
      advice: adviceController.text.trim(),
      remarks: remarksController.text.trim(),
      followUpDate: followUpDate,
    );

    await _firestoreService.saveConsultationNotes(
      appointmentId: widget.appointmentId,
      note: note,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Consultation Saved Successfully"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Consultation Notes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            buildField(
              controller: diagnosisController,
              label: "Diagnosis",
              icon: Icons.local_hospital,
            ),

            buildField(
              controller: prescriptionController,
              label: "Prescription",
              icon: Icons.receipt_long,
            ),

            buildField(
              controller: medicinesController,
              label: "Medicines",
              icon: Icons.medication,
              maxLines: 3,
            ),

            buildField(
              controller: adviceController,
              label: "Advice",
              icon: Icons.tips_and_updates,
              maxLines: 3,
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today),

                title: Text(
                  followUpDate == null
                      ? "Select Follow-up Date"
                      : followUpDate.toString().split(" ")[0],
                ),

                trailing: const Icon(Icons.arrow_forward_ios),

                onTap: pickFollowUpDate,
              ),
            ),

            const SizedBox(height: 20),

            buildField(
              controller: remarksController,
              label: "Doctor Remarks",
              icon: Icons.note_alt,
              maxLines: 4,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              height: 55,

              child: ElevatedButton(
                onPressed: saveConsultation,

                child: const Text(
                  "Save Consultation",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: TextField(
        controller: controller,
        maxLines: maxLines,

        decoration: InputDecoration(
          labelText: label,

          prefixIcon: Icon(icon),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}