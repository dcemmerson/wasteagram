import 'package:flutter/material.dart';

import 'package:wasteagram/routes/routes.dart';

class WasteagramApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.routes,
    );
  }
}
