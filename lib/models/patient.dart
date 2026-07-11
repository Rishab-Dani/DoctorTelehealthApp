class Patient {
  final String id;
  final String name;
  final int age;
  final String phone;
  final DateTime appointmentTime;
  final bool confirmed;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.appointmentTime,
    required this.confirmed,
  });
}