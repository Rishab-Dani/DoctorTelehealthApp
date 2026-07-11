import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<int> appointmentCount() {
    return _firestore
        .collection("appointments")
        .snapshots()
        .map((event) => event.docs.length);
  }

  Stream<int> noteCount() {
    return _firestore
        .collectionGroup("session_notes")
        .snapshots()
        .map((event) => event.docs.length);
  }
}