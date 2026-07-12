class ConsultationNote {
  final String diagnosis;
  final String prescription;
  final String medicines;
  final String advice;
  final String remarks;
  final DateTime? followUpDate;

  ConsultationNote({
    required this.diagnosis,
    required this.prescription,
    required this.medicines,
    required this.advice,
    required this.remarks,
    this.followUpDate,
  });

  Map<String, dynamic> toMap() {
    return {
      "diagnosis": diagnosis,
      "prescription": prescription,
      "medicines": medicines,
      "advice": advice,
      "remarks": remarks,
      "followUpDate": followUpDate,
    };
  }
}