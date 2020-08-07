import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/waste_post.dart';

class WastePostPage extends StatefulWidget {
  static const route = '/waste_post';
  static const title = 'Add Some Waste';

  @override
  _WastePostPageState createState() => _WastePostPageState();
}

class _WastePostPageState extends State<WastePostPage> {
  @override
  Widget build(BuildContext context) {
    return WastePost();
  }
}
