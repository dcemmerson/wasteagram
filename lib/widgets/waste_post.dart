import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:wasteagram/services/hardware/image_picker_manager.dart';
import 'package:wasteagram/services/hardware/location_manager.dart';

import 'package:wasteagram/widgets/error_message.dart';
import 'package:wasteagram/widgets/forms/waste_post_form.dart';
import 'package:wasteagram/widgets/loading_content.dart';
import 'package:wasteagram/widgets/location_denied.dart';

class WastePost extends StatefulWidget {
  @override
  _WastePostState createState() => _WastePostState();
}

class _WastePostState extends State<WastePost> {
  final ImagePickerManager _imagePickerManager;
  final LocationManager _locationManager;

  Future<LocationData> locationData;
  Future<File> photoFile;

  _WastePostState()
      : _imagePickerManager = ImagePickerManager.getInstance(),
        _locationManager = LocationManager.getInstance();

  @override
  void initState() {
    super.initState();
    locationData = _locationManager.getUserLocation();
    photoFile = _imagePickerManager.getImage();
  }

  Widget _pickImage() {
    return FutureBuilder(
        future: photoFile,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return WastePostForm();
          } else if (snapshot.hasError == null) {
            return ErrorMessage(message: 'An error seems to have occurred');
          } else {
            return LoadingContent(message: 'Choosing a photo...');
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locationData,
      builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
        if (snapshot.hasData) {
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
}
