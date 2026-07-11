import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // firestoreDatabase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // login method
  Future<UserCredential> login(
      String email,
      String password,
      ) {

    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // validate by role
  Future<String?> getUserRole() async {
    final user = _auth.currentUser;

    if (user == null) return null;

    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) return null;

    return doc.data()?['role'];
  }

  // logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  //validates current user
  User? get currentUser => _auth.currentUser;
}