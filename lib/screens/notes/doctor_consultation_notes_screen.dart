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
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff2F80ED),
                    Color(0xff4F8EF7),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha:.20),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Row(
                children: [

                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.edit_note_rounded,
                      color: Color(0xff2F80ED),
                      size: 34,
                    ),
                  ),

                  const SizedBox(width: 18),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Consultation Notes",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Complete the doctor's consultation details",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),

                      ],
                    ),
                  )

                ],
              ),
            ),
            const SizedBox(height: 22),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [

                  buildField(
                    controller: diagnosisController,
                    label: "Diagnosis",
                    icon: Icons.local_hospital,
                  ),

                  const SizedBox(height: 18),
                  buildField(
                    controller: prescriptionController,
                    label: "Prescription",
                    icon: Icons.receipt_long,
                  ),

                  const SizedBox(height: 18),
                  buildField(
                    controller: medicinesController,
                    label: "Medicines",
                    icon: Icons.medication,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 18),
                  buildField(
                    controller: adviceController,
                    label: "Advice",
                    icon: Icons.tips_and_updates,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 18),
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

                  const SizedBox(height: 18),

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
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: _inputDecoration(
        hint: label,
        icon: icon,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,

      prefixIcon: Icon(
        icon,
        color: const Color(0xff2F80ED),
        size: 22,
      ),

      filled: true,
      fillColor: const Color(0xffF7FAFF),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.blue.shade100,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Color(0xff2F80ED),
          width: 2,
        ),
      ),
    );
  }
}