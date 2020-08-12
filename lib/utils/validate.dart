import 'dart:io';

import 'package:location/location.dart';

/// filename: validate.dart
/// last modified: 08/11/2020
/// description: Contains form validation methods used in conjunction with
///   flutter Form widget. These methods all take strings (since user would
///   be entering strings) as arguments and either returns either the error
///   string (if provided, else default value), or null, if provided value
///   meets criteria.

class Validate {
  static const defaultErrorMessage = 'Field is required';
  static const defaultNumberErrorMessage = 'Must be valid number';
  static const defaultFileErrorMessage = 'Must be valid photo';
  static const defaultLocationErrorMessage = 'Must be valid location (lat/lng)';

  static String emptyString(String value, {errorMessage: defaultErrorMessage}) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String number(String value,
      {errorMessage: defaultNumberErrorMessage}) {
    if (value == null ||
        value.isEmpty ||
        !_isInteger(value) ||
        int.parse(value) < 0) {
      return errorMessage;
    }
    return null;
  }

  static String date(dynamic value, {errorMessage: defaultNumberErrorMessage}) {
    if (value == null || value is! DateTime) {
      return errorMessage;
    }
    return null;
  }

  static String file(dynamic value, {errorMessage: defaultFileErrorMessage}) {
    if (value == null || value is! File) {
      return errorMessage;
    }
    return null;
  }

  static String location(dynamic value,
      {errorMessage: defaultLocationErrorMessage}) {
    if (value == null || value is! LocationData) {
      print(errorMessage);
      return errorMessage;
    }
    return null;
  }

  static bool _isInteger(String value) {
    try {
      var checkedInt = int.parse(value);
      return checkedInt is int;
    } catch (err) {
      return false;
    }
  }
}
