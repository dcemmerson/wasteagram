import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:wasteagram/bloc/waste_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/services/hardware/image_picker_manager.dart';
import 'package:wasteagram/utils/styles.dart';
import 'package:wasteagram/widgets/error_message.dart';

class WastePostForm extends StatefulWidget {
  @override
  _WastePostFormState createState() => _WastePostFormState();
}

class _WastePostFormState extends State<WastePostForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePickerManager _imagePickerManager;
  WasteBloc _bloc;

  _WastePostFormState()
      : _imagePickerManager = ImagePickerManager.getInstance();

  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = WasteagramStateContainer.of(context).blocProvider.wasteBloc;
  }

  Widget itemNameField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(
            AppPadding.p5, AppPadding.p7, AppPadding.p5, AppPadding.p5),
        child: TextFormField(
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
          keyboardType: TextInputType.number,
          decoration:
              InputDecoration(labelText: 'Count', border: OutlineInputBorder()),
        ));
  }

  Widget latLngField(LocationData locationData) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          AppPadding.p5, AppPadding.p2, AppPadding.p5, AppPadding.p5),
      child: FormField(
          builder: (field) => Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Icon(Icons.gps_not_fixed),
                    Padding(
                        padding: EdgeInsets.all(AppPadding.p3),
                        child:
                            Text('Lat: ' + locationData.latitude.toString())),
                    Padding(
                        padding: EdgeInsets.all(AppPadding.p3),
                        child:
                            Text('Lng: ' + locationData.longitude.toString()))
                  ]))),
    );
  }

  Widget itemPhotoField(File photo) {
    return FormField(builder: (field) {
      return Container(
          width: 500,
          height: 200,
          child: Image.file(photo,
              semanticLabel: 'Photo to upload', fit: BoxFit.contain));
    });
  }

  Widget _buildForm(PhotoTaken photoTaken) {
    return SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                itemNameField(),
                itemCountField(),
                itemPhotoField(photoTaken.photo),
                latLngField(photoTaken.locationData),
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
