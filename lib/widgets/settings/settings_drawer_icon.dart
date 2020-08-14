import 'package:flutter/material.dart';

class SettingsDrawerIcon extends StatelessWidget {
  void showThemeDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Semantics(
            button: true,
            hint: 'Open settings drawer',
            label: 'Settings',
            child: GestureDetector(
              child: Icon(Icons.settings),
              onTap: () => showThemeDrawer(context),
            )));
  }
}
