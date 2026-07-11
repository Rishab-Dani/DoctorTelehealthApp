import 'package:flutter/material.dart';
import '../models/patient.dart';

class PatientCard extends StatelessWidget {

  final Patient patient;

  const PatientCard({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(

              children: [

                const CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.person),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      patient.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text("Patient ID : ${patient.id}")

                  ],
                )

              ],

            ),

            const Divider(height: 30),

            Text("Age : ${patient.age}"),

            Text("Phone : ${patient.phone}"),

            Text("Status : ${patient.confirmed ? "Confirmed" : "Unconfirmed"}"),

          ],
        ),
      ),
    );
  }
}