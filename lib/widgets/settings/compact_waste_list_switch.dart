import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/styles/styles.dart';

class CompactWasteListSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WasteagramState wasteagramState = WasteagramStateContainer.of(context);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('Compact ', style: TextStyle(fontSize: AppFonts.h3)),
      Switch(
          value: wasteagramState.isCompactWasteListMode,
          onChanged: (value) => wasteagramState.toggleCompactWasteListMode()),
    ]);
  }
}
