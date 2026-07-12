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
  final String roomId;
  //consolation notes
  final String diagnosis;
  final String prescription;
  final String medicines;
  final String advice;
  final String remarks;
  final DateTime? followUpDate;

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
    required this.roomId,
    required this.diagnosis,
    required this.prescription,
    required this.medicines,
    required this.advice,
    required this.remarks,
    this.followUpDate,
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

      roomId: data['roomId'] ?? '',
      diagnosis: data['diagnosis'] ?? '',
      prescription: data['prescription'] ?? '',
      medicines: data['medicines'] ?? '',
      advice: data['advice'] ?? '',
      remarks: data['remarks'] ?? '',
      followUpDate:
      data['followUpDate'] != null
          ? (data['followUpDate'] as Timestamp).toDate()
          : null,
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
      'roomId': roomId,
      'diagnosis': diagnosis,
      'prescription': prescription,
      'medicines': medicines,
      'advice': advice,
      'remarks': remarks,
      'followUpDate': followUpDate,
    };
  }
}