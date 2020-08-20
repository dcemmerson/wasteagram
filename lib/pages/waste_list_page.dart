import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/waste_list_view/waste_items_list.dart';

class WasteListPage extends StatelessWidget {
  static const route = '/';
  static const title = 'Waste Items';

  @override
  Widget build(BuildContext context) {
    return WasteItems();
  }
}
