import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../services/firestore_service.dart';

class AppointmentProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();

  Stream<List<Appointment>> get appointments =>
      _service.getAppointments();

  Stream<List<Appointment>> get patientAppointments =>
      _service.getPatientAppointments();
}