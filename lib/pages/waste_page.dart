import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/waste_items.dart';

class WastePage extends StatefulWidget {
  static const route = '/';
  static const title = 'Waste Items';

  @override
  _WastePageState createState() => _WastePageState();
}

class _WastePageState extends State<WastePage> {
  @override
  Widget build(BuildContext context) {
    return WasteItems();
  }
}
