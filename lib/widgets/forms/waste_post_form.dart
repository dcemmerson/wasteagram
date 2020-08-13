import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:wasteagram/bloc/waste_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/services/hardware/image_picker_manager.dart';
import 'package:wasteagram/styles/styles.dart';
import 'package:wasteagram/utils/validate.dart';
import 'package:wasteagram/widgets/forms/date_time_form_field.dart';
import 'package:wasteagram/widgets/misc/error_message.dart';

class WastePostForm extends StatefulWidget {
  @override
  _WastePostFormState createState() => _WastePostFormState();
}

class _WastePostFormState extends State<WastePostForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePickerManager _imagePickerManager;
  WasteBloc _bloc;
  AddWasteItem addWasteItem = AddWasteItem();
  bool _formChanged = false;

  _WastePostFormState()
      : _imagePickerManager = ImagePickerManager.getInstance();

  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = WasteagramStateContainer.of(context).blocProvider.wasteBloc;
  }

  void _onFormChanged() {
    if (!_formChanged) {
      setState(() => _formChanged = true);
    }
  }

  Future<bool> _onWillPop() {
    if (!_formChanged) {
      return Future<bool>.value(true);
    }
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Text(
                  'Are you sure you want to abandon form? Unsaved changes will be lost.'),
              actions: [
                FlatButton(
                    child: Text('Abandon'),
                    textColor: Colors.red,
                    onPressed: () => Navigator.pop(context, true)),
                FlatButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context, false)),
              ],
            ));
  }

  Widget itemNameField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(
            AppPadding.p5, AppPadding.p7, AppPadding.p5, AppPadding.p5),
        child: TextFormField(
          validator: (value) => Validate.emptyString(value),
          onSaved: (value) => addWasteItem.name = value,
          keyboardType: TextInputType.text,
          decoration:
              InputDecoration(labelText: 'Item', border: OutlineInputBorder()),
        ));
  }

  Widget itemCountField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(
            AppPadding.p5, AppPadding.p7, AppPadding.p5, AppPadding.p5),
        child: TextFormField(
          validator: (value) => Validate.number(value),
          onSaved: (value) => addWasteItem.count = int.parse(value),
          keyboardType: TextInputType.number,
          decoration:
              InputDecoration(labelText: 'Count', border: OutlineInputBorder()),
        ));
  }

  Widget itemDateField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(
            AppPadding.p5, AppPadding.p7, AppPadding.p5, AppPadding.p5),
        child: DateTimeFormField(
          onSaved: (date) => addWasteItem.date = date,
        ));
  }

  Widget latLngField(LocationData locationData) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          AppPadding.p5, AppPadding.p2, AppPadding.p5, AppPadding.p5),
      child: FormField(
        initialValue: locationData,
        validator: (value) => Validate.location(value),
        onSaved: (value) => addWasteItem.locationData = value,
        builder: (field) {
          return Center(
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.gps_not_fixed),
                Padding(
                    padding: EdgeInsets.all(AppPadding.p3),
                    child: Text('Lat: ' + locationData.latitude.toString())),
                Padding(
                    padding: EdgeInsets.all(AppPadding.p3),
                    child: Text('Lng: ' + locationData.longitude.toString()))
              ]),
            ]),
          );
        },
      ),
    );
  }

  Widget itemPhotoField(File photo) {
    return FormField(
        initialValue: photo,
        validator: (value) => Validate.file(value),
        onSaved: (value) => addWasteItem.photo = value,
        builder: (field) {
          return Container(
              height: MediaQuery.of(context).size.height * (2 / 3),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Image.file(
                              photo,
                              semanticLabel: 'Photo to upload',
                            )))
                  ]));
        });
  }

  Widget itemUploadButton() {
    var currWidth = MediaQuery.of(context).size.width;
    var currHeight = MediaQuery.of(context).size.height;

    return Container(
        child: FlatButton(
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(AppPadding.p0),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _bloc.addWasteItemSink.add(addWasteItem);
                Navigator.of(context).pop();
              }
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.cloud_upload,
                size: currWidth > currHeight ? currHeight / 3 : currWidth / 3,
              ),
            ])));
  }

  Widget _buildForm(PhotoTaken photoTaken) {
    return SingleChildScrollView(
        child: Form(
            key: _formKey,
            onChanged: _onFormChanged,
            onWillPop: _onWillPop,
            child: Column(
              children: [
                itemNameField(),
                itemCountField(),
                itemDateField(),
                itemPhotoField(photoTaken.photo),
                latLngField(photoTaken.locationData),
                itemUploadButton(),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.photoTaken,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            } else {
              return _buildForm(snapshot.data);
            }
          } else if (snapshot.hasError) {
            return ErrorMessage(message: 'Something unexpected happened...');
          } else {
            return Text('loading?');
          }
        });
  }
}
