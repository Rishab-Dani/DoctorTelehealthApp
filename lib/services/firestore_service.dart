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
}