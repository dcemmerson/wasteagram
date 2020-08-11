import 'package:flutter/material.dart';
import 'package:wasteagram/utils/styles.dart';

class LocationDenied extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Access to location needed',
          style: TextStyle(fontSize: AppFonts.h3)),
      Text('Please enable location in settings',
          style: TextStyle(fontSize: AppFonts.h5)),
    ]));
  }
}
