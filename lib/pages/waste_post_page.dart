import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/waste_post.dart';

class WastePostPage extends StatelessWidget {
  static const route = '/waste_post';
  static const title = 'New Waste Post';

  @override
  Widget build(BuildContext context) {
    return WastePost();
  }
}
