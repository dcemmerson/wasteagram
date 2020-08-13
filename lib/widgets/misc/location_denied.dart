import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';

import 'package:wasteagram/styles/styles.dart';

class LocationDenied extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Location services must be enabled.',
          style: TextStyle(fontSize: AppFonts.h3)),
      FlatButton(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Settings ', style: TextStyle(fontSize: AppFonts.h5)),
          Icon(Icons.settings)
        ]),
        onPressed: AppSettings.openLocationSettings,
      )
    ]));
  }
}
