import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy • hh:mm a').format(dateTime);
  }
}