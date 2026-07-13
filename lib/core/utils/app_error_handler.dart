import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppErrorHandler {
  static void showError(BuildContext context, Object error) {
    String message = "Something went wrong. Please try again.";

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case "user-not-found":
          message = "No user found with this email.";
          break;

        case "wrong-password":
          message = "Incorrect password.";
          break;

        case "invalid-email":
          message = "Invalid email address.";
          break;

        case "email-already-in-use":
          message = "Email is already registered.";
          break;

        case "weak-password":
          message = "Password is too weak.";
          break;

        case "network-request-failed":
          message = "No internet connection.";
          break;

        default:
          message = error.message ?? "Authentication failed.";
      }
    }

    else if (error is FirebaseException) {
      switch (error.code) {
        case "unavailable":
          message = "Server unavailable. Please try again.";

          break;

        case "permission-denied":
          message = "Permission denied.";

          break;

        case "network-request-failed":
          message = "No internet connection.";

          break;

        case "deadline-exceeded":
          message = "Request timed out.";

          break;

        default:
          message = error.message ?? "Database error.";
      }
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),

        backgroundColor: Colors.red,

        behavior: SnackBarBehavior.floating,

        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),

        backgroundColor: Colors.green,

        behavior: SnackBarBehavior.floating,

        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),

        backgroundColor: Colors.blue,

        behavior: SnackBarBehavior.floating,

        duration: const Duration(seconds: 2),
      ),
    );
  }
}