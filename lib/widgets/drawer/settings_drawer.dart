import 'package:flutter/material.dart';
import 'package:wasteagram/styles/styles.dart';
import 'package:wasteagram/widgets/drawer/compact_waste_list_switch.dart';
import 'package:wasteagram/widgets/drawer/account_dropdown.dart';
import 'package:wasteagram/widgets/drawer/theme_switch.dart';

class SettingsDrawer extends StatelessWidget {
  final Key drawerKey = GlobalKey();

  DrawerHeader drawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Row(children: [
              Text('Wasteagram settings',
                  style: TextStyle(
                      fontSize: AppFonts.h3,
                      color: Theme.of(context).primaryColorLight))
            ]),
          ),
          Expanded(
            child: LoginButton(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        key: drawerKey,
        child: Column(
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
