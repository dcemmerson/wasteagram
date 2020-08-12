import 'package:flutter/material.dart';
import 'package:wasteagram/utils/styles.dart';

class EmptyPostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(children: [
          Padding(
              padding: EdgeInsets.all(AppPadding.p4),
              child: Text('No posts to display')),
          Padding(
              padding: EdgeInsets.all(AppPadding.p4),
              child: CircularProgressIndicator()),
        ]));
  }
}
