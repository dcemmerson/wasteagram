import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:wasteagram/utils/validate.dart';

typedef OnSaved = void Function(DateTime date);

class DateTimeFormField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  final OnSaved onSaved;
  DateTimeFormField({@required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
        initialValue: DateTime.now(),
        validator: (value) => Validate.date(value),
        onSaved: onSaved,
        decoration:
            InputDecoration(labelText: 'Date', border: OutlineInputBorder()),
        format: format.add_jm(),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          );
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        });
  }
}
