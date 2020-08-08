import 'package:flutter/material.dart';
import 'package:wasteagram/utils/styles.dart';
import 'package:wasteagram/widgets/forms/waste_post_form.dart';

class WastePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(
            AppPadding.p5, AppPadding.p7, AppPadding.p5, AppPadding.p5),
        child: WastePostForm());
  }
}
