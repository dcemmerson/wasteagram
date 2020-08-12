import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/waste_list_view/waste_items_list.dart';

class WasteListPage extends StatefulWidget {
  static const route = '/';
  static const title = 'Waste Items';

  @override
  _WastePageState createState() => _WastePageState();
}

class _WastePageState extends State<WasteListPage> {
  @override
  Widget build(BuildContext context) {
    return WasteItems();
  }
}
