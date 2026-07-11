class Patient {

  final String id;
  final String name;
  final String email;
  final String phone;
  final int age;

  Patient({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
  });

  factory Patient.fromFirestore(
      String id,
      Map<String, dynamic> json,
      ) {
    return Patient(
      id: id,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      age: json["age"] ?? 0,
    );
  }
}