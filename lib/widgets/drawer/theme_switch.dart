import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/styles/styles.dart';

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WasteagramState wasteagramState = WasteagramStateContainer.of(context);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('Dark Mode ', style: TextStyle(fontSize: AppFonts.h3)),
      Semantics(
        button: true,
        label: 'Dark mode',
        hint: 'Toggle dark mode',
        toggled: wasteagramState.isDarkMode,
        child: Switch(
            value: wasteagramState.isDarkMode,
            onChanged: (value) => wasteagramState.toggleDarkMode()),
      )
    ]);
  }
}
