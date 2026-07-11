import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment.dart';

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
}