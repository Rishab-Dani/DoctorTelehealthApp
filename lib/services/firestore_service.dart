import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment.dart';
import '../models/session_note.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}