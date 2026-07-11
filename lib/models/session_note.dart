import 'package:cloud_firestore/cloud_firestore.dart';

class SessionNote {

  final String id;

  final String note;

  final DateTime createdAt;

  SessionNote({

    required this.id,

    required this.note,

    required this.createdAt,

  });

  factory SessionNote.fromFirestore(DocumentSnapshot doc) {

    final data =
    doc.data() as Map<String, dynamic>;

    return SessionNote(

      id: doc.id,

      note: data["note"] ?? "",

      createdAt:

      data["createdAt"] == null

          ? DateTime.now()

          : (data["createdAt"] as Timestamp).toDate(),

    );

  }

}