import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerManager {
  static ImagePickerManager _instance;

  final ImagePicker picker;

  ImagePickerManager._() : picker = ImagePicker();

  factory ImagePickerManager.getInstance() {
    if (_instance == null) {
      _instance = ImagePickerManager._();
    }
    return _instance;
  }

  Future<File> getImage({ImageSource imageSource: ImageSource.camera}) async {
    final pickedFile = await picker.getImage(source: imageSource);
    return File(pickedFile.path);
  }
}
