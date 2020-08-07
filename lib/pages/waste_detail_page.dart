import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/waste_item_detail.dart';
import 'package:wasteagram/widgets/waste_items.dart';

class WasteDetailPage extends StatefulWidget {
  static const route = '/wastedetail';
  static const title = 'Waste Details';

  @override
  _WasteDetailPageState createState() => _WasteDetailPageState();
}

class _WasteDetailPageState extends State<WasteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return WasteItemDetail();
  }
}
