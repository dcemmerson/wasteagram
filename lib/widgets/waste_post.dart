import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wasteagram/bloc/waste_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/services/hardware/image_picker_manager.dart';
import 'package:wasteagram/services/hardware/location_manager.dart';
import 'package:wasteagram/styles/styles.dart';

import 'package:wasteagram/widgets/misc/error_message.dart';
import 'package:wasteagram/widgets/forms/waste_post_form.dart';
import 'package:wasteagram/widgets/misc/loading_content.dart';
import 'package:wasteagram/widgets/misc/location_denied.dart';

class WastePost extends StatefulWidget {
  final ImagePickerManager _imagePickerManager;
  final LocationManager _locationManager;

  WastePost()
      : _imagePickerManager = ImagePickerManager.getInstance(),
        _locationManager = LocationManager.getInstance();

  @override
  _WastePostState createState() => _WastePostState();
}

class _WastePostState extends State<WastePost> {
  WasteBloc _bloc;

  ImageSource imageSource = ImageSource.camera;

  Future<LocationData> locationDataF;
  Future<File> photoFileF;
  LocationData locationData;
  File photoFile;

  @override
  void initState() {
    super.initState();
    locationDataF = widget._locationManager.getUserLocation();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = WasteagramStateContainer.of(context).blocProvider.wasteBloc;
  }

  Widget _pickImage() {
    photoFileF = widget._imagePickerManager.getImage(imageSource: imageSource);
    return FutureBuilder(
        future: photoFileF,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              print('connection state == done\n\n\n\n\n\n\n\n\n\n');
              print(snapshot.data);
              if (snapshot.data != null) {
                photoFile = snapshot.data;
                _bloc.photoTakenSink.add(
                    PhotoTaken(locationData: locationData, photo: photoFile));
                return WastePostForm();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                      button: true,
                      hint: 'Take a photo with device camera',
                      label: 'Take Photo',
                      child: FlatButton(
                          onPressed: () =>
                              setState(() => imageSource = ImageSource.camera),
                          child: Padding(
                              padding: EdgeInsets.all(AppPadding.p7),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Take photo'),
                                    Padding(
                                        padding: EdgeInsets.all(AppPadding.p4),
                                        child: Icon(Icons.photo_camera))
                                  ])))),
                  Semantics(
                      button: true,
                      label: 'Choose from Gallery',
                      hint: 'Choose photo from gallery',
                      child: FlatButton(
                          onPressed: () =>
                              setState(() => imageSource = ImageSource.gallery),
                          child: Padding(
                              padding: EdgeInsets.all(AppPadding.p7),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('From gallery'),
                                    Padding(
                                        padding: EdgeInsets.all(AppPadding.p4),
                                        child: Icon(Icons.photo_library))
                                  ]))))
                ],
              );
            default:
              if (snapshot.hasError) {
                return const Text('Error');
              } else {
                return const Text('No image picked yet');
              }
          }
        });
  }

  Widget _askUserLocation() {
    return FutureBuilder(
      future: locationDataF,
      builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
        if (snapshot.hasData) {
          locationData = snapshot.data;
          return _pickImage();
        } else if (snapshot.data == null) {
          return LocationDenied();
        } else if (snapshot.hasError) {
          return ErrorMessage(message: 'An error seems to have occurred');
        } else {
          return LoadingContent(message: 'Loading location data');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Before rendering actual form (aka WastePostForm):
    // first make sure we can access the user's location, then we have the user
    // either take a photo or select a photo from gallery. If user declines
    // any permissions, or device does not have necesary hardware, just display
    // message to user stating permissions/device hardware needed to continue.
    return _askUserLocation();
  }
}
