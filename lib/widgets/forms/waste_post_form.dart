import 'package:flutter/material.dart';
import 'package:wasteagram/utils/styles.dart';

class WastePostForm extends StatefulWidget {
  @override
  _WastePostFormState createState() => _WastePostFormState();
}

class _WastePostFormState extends State<WastePostForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(
            AppPadding.p5, AppPadding.p7, AppPadding.p5, AppPadding.p5),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Item', border: OutlineInputBorder()),
                ),
                TextFormField()
              ],
            )));
  }
}
