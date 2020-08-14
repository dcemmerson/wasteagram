import 'package:flutter/material.dart';

class TestScaffold extends StatelessWidget {
  final Widget child;
  TestScaffold({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: child,
    ));
  }
}
