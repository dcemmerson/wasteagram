import 'package:flutter/material.dart';

class ThemeDrawerIcon extends StatelessWidget {
  void showThemeDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      child: Icon(Icons.settings),
      onTap: () => showThemeDrawer(context),
    ));
  }
}
