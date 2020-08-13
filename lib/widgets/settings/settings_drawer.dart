import 'package:flutter/material.dart';
import 'package:wasteagram/styles/styles.dart';
import 'package:wasteagram/widgets/settings/compact_waste_list_switch.dart';

import 'package:wasteagram/widgets/settings/theme_switch.dart';

class SettingsDrawer extends StatelessWidget {
  final Key drawerKey = GlobalKey();

  DrawerHeader drawerHeader(BuildContext context) {
    return DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Text('Wasteagram settings',
            style: TextStyle(
                fontSize: 24, color: Theme.of(context).primaryColorLight)));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        key: drawerKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            drawerHeader(context),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  AppPadding.p7, AppPadding.p4, AppPadding.p7, AppPadding.p2),
              child: ThemeSwitch(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  AppPadding.p7, AppPadding.p2, AppPadding.p7, AppPadding.p4),
              child: CompactWasteListSwitch(),
            ),
          ],
        ));
  }
}
