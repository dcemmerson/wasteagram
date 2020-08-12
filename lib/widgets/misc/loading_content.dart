import 'package:flutter/material.dart';
import 'package:wasteagram/utils/styles.dart';

class LoadingContent extends StatelessWidget {
  final message;

  LoadingContent({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Semantics(
        label: message,
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(message, style: TextStyle(fontSize: AppFonts.h6)),
          CircularProgressIndicator(),
        ])));
  }
}
