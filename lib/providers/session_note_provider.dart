import 'package:flutter/material.dart';

import '../models/session_note.dart';
import '../services/firestore_service.dart';

class SessionNoteProvider extends ChangeNotifier {

  final FirestoreService _service =
  FirestoreService();

  Stream<List<SessionNote>> notes(
      String appointmentId,
      ) {
    return _service.getSessionNotes(
      appointmentId,
    );
  }

  Future<void> addNote(
      String appointmentId,
      String note,
      ) async {

    await _service.addSessionNote(
      appointmentId,
      note,
    );

  }

}