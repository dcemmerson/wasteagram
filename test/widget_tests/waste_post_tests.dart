import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/bloc/waste_bloc.dart';
import 'package:wasteagram/models/wasted_item.dart';
import 'package:wasteagram/services/network/waste_service.dart';
import 'package:wasteagram/utils/date.dart';
import 'package:wasteagram/widgets/waste_list_view/compact_list_tile.dart';

void wastePostTests() {
  testWidgets('testing waste list compact view (not mocked)',
      (WidgetTester tester) async {
//    WasteBloc wasteBloc = WasteBloc(MockWasteService());

    var wasteService = WasteService();
    var wasteBloc = WasteBloc(wasteService);

    await for (var items in wasteBloc.wastedItems) {
      for (WastedItem item in items) {
        await tester.pumpWidget(MaterialApp(
            home: Scaffold(
                body: CompactListTile(
          wastedItem: item,
        ))));

        expect(find.text(item.name), findsNothing);
        expect(find.text(item.count.toString()), findsOneWidget);
        expect(find.text(Date.humanizeTimestamp(item.date)), findsOneWidget);
      }
      break;
    }
  });
}
