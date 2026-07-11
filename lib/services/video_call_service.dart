import 'package:firebase_auth/firebase_auth.dart';

class VideoCallService {

  static String getUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static String getUserName() {

    final user = FirebaseAuth.instance.currentUser;

    return user?.email ?? "Doctor";

  }

  static String generateCallId(String appointmentId) {

    return "appointment_$appointmentId";

  }

}