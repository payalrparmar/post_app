import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_app/Dialog/image_picker_dialog.dart';

class ImagePickerHandler {
  ImagePickerDialog imagePicker;
  AnimationController _controller;
  ImagePickerListener _listener;
  String _isFor;
  ImagePickerHandler(this._listener, this._controller);

  openCamera() async {
    imagePicker.dismissDialog();
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxHeight: 1200,
        maxWidth: 1200);
    _listener.userImage(image, _isFor);
/*
    widget.handlerCallback(image);
*/
  }

  openGallery() async {
    imagePicker.dismissDialog();
//    Future<File> imageFile = ImagePicker.pickImage(source: ImageSource.gallery  , maxHeight:  200 , maxWidth: 200 );
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1200, maxWidth: 1200);
    //cropImage(image);
    _listener.userImage(image, _isFor);
  }

  void init() {
    imagePicker = new ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }

  showDialog(BuildContext context /*,String orderNumber*/) {
    print("fffff");
    imagePicker.getImage(context);
    // _isFor=orderNumber;
  }
}

abstract class ImagePickerListener {
  userImage(File _image, String _isFor);
}
