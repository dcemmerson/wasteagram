import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:wasteagram/bloc/waste_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/models/wasted_item.dart';
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

  FocusNode nameFocus;
  FocusNode countFocus;

  WasteBloc _bloc;
  AddWasteItem addWasteItem = AddWasteItem();
  bool _formChanged = false;
  bool _itemUploading = false;

  void initState() {
    super.initState();
    nameFocus = FocusNode();
    countFocus = FocusNode();
  }

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
          focusNode: nameFocus,
          key: ValueKey('itemNameField'),
          validator: (value) {
            String valid = Validate.emptyString(value);
            if (valid != null) FocusScope.of(context).requestFocus(nameFocus);

            return valid;
          },
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
          focusNode: countFocus,
          key: ValueKey('itemCountField'),
          validator: (value) {
            String valid = Validate.number(value);
            if (valid != null) FocusScope.of(context).requestFocus(countFocus);

            return valid;
          },
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
        key: ValueKey('itemLatLngField'),
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
    double buttonSize = currWidth > currHeight ? currHeight / 3 : currWidth / 3;

    return Container(
        child: Semantics(
            button: true,
            hint: 'Upload wasted item to cloud',
            label: 'Upload',
            enabled: !_itemUploading,
            child: FlatButton(
                key: ValueKey('itemUploadButton'),
                color: Theme.of(context).accentColor,
                disabledColor: Theme.of(context).disabledColor,
                padding: EdgeInsets.all(AppPadding.p0),
                onPressed: (_itemUploading || !_formChanged)
                    ? null
                    : () async {
                        setState(() => _itemUploading = true);
                        if (_formKey.currentState.validate()) {
                          await saveToCloud();
                        }
                        setState(() => _itemUploading = false);
                      },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _itemUploading
                      ? Container(
                          height: buttonSize,
                          width: buttonSize,
                          child: CircularProgressIndicator())
                      : Icon(Icons.cloud_upload, size: buttonSize),
                ]))));
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

  Future saveToCloud() async {
    _formKey.currentState.save();
    _bloc.addWasteItemSink.add(addWasteItem);

    bool itemUploadSuccess = false;

    Future<bool> uploadSuccess =
        isItemUploaded(addWasteItem).then((value) => itemUploadSuccess = value);
    Future<bool> uploadTimeout = itemUploadTimeout();

    await Future.any([uploadSuccess, uploadTimeout]);
    if (itemUploadSuccess) {
      Navigator.of(context).pop();
    } else {
      showErrorSaving();
    }
  }

  Future<bool> isItemUploaded(AddWasteItem addWasteItem) async {
    await for (var items in _bloc.wastedItems) {
      for (WastedItem item in items) {
        if (item.name == addWasteItem.name &&
            item.count == addWasteItem.count &&
            item.location == item.location) {
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> itemUploadTimeout({seconds: 5}) async {
    await Future.delayed(Duration(seconds: seconds));
    return true;
  }

  Future showErrorSaving() {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Text('Unable to save post at this time.'),
              actions: [
                FlatButton(
                    child: Text('Ok'), onPressed: () => Navigator.pop(context)),
              ],
            ));
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
