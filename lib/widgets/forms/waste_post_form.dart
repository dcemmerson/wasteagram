import 'package:flutter/material.dart';

class WastePostForm extends StatefulWidget {
  @override
  _WastePostFormState createState() => _WastePostFormState();
}

class _WastePostFormState extends State<WastePostForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Item', border: OutlineInputBorder()),
            ),
            TextFormField()
          ],
        ));
  }
}
