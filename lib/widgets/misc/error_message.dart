import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final message;

  ErrorMessage({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(message)],
    );
  }
}
