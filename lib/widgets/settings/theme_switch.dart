import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/styles/styles.dart';

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WasteagramState wasteagramState = WasteagramStateContainer.of(context);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('Dark Mode ', style: TextStyle(fontSize: AppFonts.h3)),
      Switch(
          value: wasteagramState.isDarkMode,
          onChanged: (value) => wasteagramState.toggleDarkMode()),
    ]);
  }
}
