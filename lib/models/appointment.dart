import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String patientId;
  final String patientName;
  final int age;
  final String phone;
  final String status;
  final DateTime appointmentTime;
  final String doctorId;
  final String doctorName;
  final String reason;
  final DateTime createdAt;

  Appointment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.age,
    required this.phone,
    required this.status,
    required this.appointmentTime,
    required this.doctorId,
    required this.doctorName,
    required this.reason,
    required this.createdAt,
  });

  factory Appointment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Appointment(
      id: doc.id,
      patientId: data['patientId'],
      patientName: data['patientName'],
      age: data['age'],
      phone: data['phone'],
      status: data['status'],
      appointmentTime:
      (data['appointmentTime'] as Timestamp).toDate(),
      doctorId: data['doctorId'] ?? '',

      doctorName: data['doctorName'] ?? '',

      reason: data['reason'] ?? '',

      createdAt:
      (data['createdAt'] as Timestamp?)?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'patientName': patientName,
      'age': age,
      'phone': phone,
      'status': status,
      'appointmentTime': appointmentTime,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'reason': reason,
      'createdAt': createdAt,
    };
  }
}