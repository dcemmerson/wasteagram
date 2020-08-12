import 'package:flutter/material.dart';
import 'package:wasteagram/routes/routes.dart';

class WasteagramApp extends StatefulWidget {
  @override
  _WasteagramAppState createState() => _WasteagramAppState();
}

class _WasteagramAppState extends State<WasteagramApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.routes,
    );
  }
}
