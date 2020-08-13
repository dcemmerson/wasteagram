import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/styles/styles.dart';

class ThemeDrawer extends StatelessWidget {
  final Key drawerKey = GlobalKey();

  DrawerHeader drawerHeader(BuildContext context) {
    return DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Text('Theme settings',
            style: TextStyle(
                fontSize: 24, color: Theme.of(context).primaryColorLight)));
  }

  Widget createThemeSwitch(BuildContext context) {
    WasteagramState wasteagramState = WasteagramStateContainer.of(context);
    return Row(children: [
      Text('Dark Mode ', style: TextStyle(fontSize: AppFonts.h3)),
      Switch(
          value: wasteagramState.isDarkMode,
          onChanged: (value) => wasteagramState.toggleDarkMode()),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        key: drawerKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            drawerHeader(context),
            createThemeSwitch(context),
          ],
        ));
  }
}
