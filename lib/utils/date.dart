import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Date {
  static const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  static const daysOfWeek = [
    'Sat',
    'Sun',
    'Mon',
    'Tu',
    'Wed',
    'Th',
    'Fri',
  ];

  static String humanizeTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return date.day.toString() +
        ' ' +
        months[date.month - 1] +
        ' ' +
        date.year.toString();
  }

  static String dayOfWeek(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('EEEE').format(date).substring(0, 3);
  }
}
