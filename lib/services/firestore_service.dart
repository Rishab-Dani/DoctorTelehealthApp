import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/appointment.dart';
import '../models/patient.dart';
import '../models/session_note.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get appointments
  Stream<List<Appointment>> getAppointments() {
    return _firestore
        .collection('appointments')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Appointment.fromFirestore(doc))
          .toList();
    });
  }

  // add notes
  Future<void> addSessionNote({
    required String appointmentId,
    required String note,
  }) async {

    await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .collection('session_notes')
        .add({

      'note': note,
      'createdAt': FieldValue.serverTimestamp(),

    });

  }

  // get session notes
  Stream<List<SessionNote>> getSessionNotes(
      String appointmentId) {

    return _firestore
        .collection('appointments')
        .doc(appointmentId)
        .collection('session_notes')
        .orderBy(
      "createdAt",
      descending: true,
    )
        .snapshots()
        .map((snapshot) {

      return snapshot.docs
          .map((doc) => SessionNote.fromFirestore(doc))
          .toList();

    });

  }

  // completed appointment
  Future<void> completeAppointment(String appointmentId) async {
    final doc = await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .get();

    if (!doc.exists) {
      throw Exception("Appointment not found.");
    }

    final status = (doc['status'] ?? '').toString().toLowerCase();

    if (status == 'completed') {
      throw Exception("Appointment is already completed.");
    }

    if (status == 'cancelled') {
      throw Exception("Cancelled appointments cannot be completed.");
    }

    await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .update({
      'status': 'completed',
      'completedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  //updating appointment
  Future<void> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  }) async {
    await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // cancelling appointment
  Future<void> cancelAppointment(String appointmentId) async {

    final doc = await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .get();

    if (!doc.exists) {
      throw Exception("Appointment not found.");
    }

    final status = (doc['status'] ?? '').toString().toLowerCase();

    if (status == 'cancelled') {
      throw Exception("Appointment is already cancelled.");
    }

    if (status == 'completed') {
      throw Exception("Completed appointments cannot be cancelled.");
    }

    await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .update({
      'status': 'cancelled',
      'cancelledAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // get current patient
  Future<Patient> getCurrentPatient() async {

    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await _firestore
        .collection("users")
        .doc(uid)
        .get();

    return Patient.fromFirestore(
      doc.id,
      doc.data()!,
    );
  }

  //booking appointment
  Future<void> bookAppointment({
    required Appointment appointment,
  }) async {

    await _firestore
        .collection('appointments')
        .add({

      ...appointment.toMap(),

      "doctorId": appointment.doctorId,
      "doctorName": appointment.doctorName,
      "reason": appointment.reason,

      "status": "Pending",

      "createdAt": FieldValue.serverTimestamp(),

    });

  }

  // get only patient Appointments
  Stream<List<Appointment>> getPatientAppointments() {

    final uid = FirebaseAuth.instance.currentUser!.uid;

    return _firestore
        .collection('appointments')
        .where('patientId', isEqualTo: uid)
        .orderBy(
      'appointmentTime',
      descending: false,
    )
        .snapshots()
        .map((snapshot) {

      return snapshot.docs
          .map((doc) => Appointment.fromFirestore(doc))
          .toList();

    });
  }
}