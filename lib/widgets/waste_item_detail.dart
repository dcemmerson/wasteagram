import 'package:flutter/material.dart';
import 'package:wasteagram/models/wasted_item.dart';
import 'package:wasteagram/utils/date.dart';
import 'package:wasteagram/utils/styles.dart';

class WasteItemDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WastedItem item = ModalRoute.of(context).settings.arguments as WastedItem;
    return Container(
        child: Column(
      children: [
        Center(
            child: Padding(
                padding: EdgeInsets.all(AppPadding.p4),
                child: Text(
                    Date.dayOfWeek(item.date) +
                        ', ' +
                        Date.humanizeTimestamp(item.date),
                    style: TextStyle(fontSize: AppFonts.h1)))),
        Expanded(child: Container(child: Text('placeholder'))),
        Center(
            child: Padding(
                padding: EdgeInsets.all(AppPadding.p6),
                child: Text(item.count.toString(),
                    style: TextStyle(fontSize: AppFonts.h3)))),
      ],
    ));
  }
}
