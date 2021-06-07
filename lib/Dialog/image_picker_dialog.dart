import 'dart:async';
import 'package:flutter/material.dart';
import 'package:post_app/Dialog/image_picker_handler.dart';
import 'package:post_app/Utils/CommonColor.dart';

class ImagePickerDialog extends StatelessWidget {
  ImagePickerHandler _listener;
  AnimationController _controller;
  BuildContext context;

  ImagePickerDialog(this._listener, this._controller);

  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  bool isDialogShow = true;

  void initState() {
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = new Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  getImage(BuildContext context) {
    if (_controller == null ||
        _drawerDetailsPosition == null ||
        _drawerContentsOpacity == null) {
      return;
    }
    _controller.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => new SlideTransition(
        position: _drawerDetailsPosition,
        child: new FadeTransition(
          opacity: new ReverseAnimation(_drawerContentsOpacity),
          child: this,
        ),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 200);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  dismissDialog() {
    _controller.reverse();
    startTime();
  }

  double buttonText;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    var bottomPadding = mediaQueryData.padding.bottom;
    double parentHeight = screenHeight - bottomPadding;
    if (parentHeight < 600.0) {
      buttonText = 9;
    } else if (parentHeight < 710) {
      buttonText = 11;
    } else if (parentHeight > 709 && parentHeight < 800) {
      buttonText = 13;
    } else if (parentHeight > 799 && parentHeight < 850) {
      buttonText = 15;
    } else if (parentHeight > 849 && parentHeight < 950) {
      buttonText = 17;
    } else if (parentHeight > 949) {
      buttonText = 18;
    }
    this.context = context;
    return GestureDetector(
      onTap: () {
        dismissDialog();
      },
      onDoubleTap: () {},
      child: new Material(
          type: MaterialType.transparency,
          child: new Opacity(
            opacity: 1.0,
            child: new Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      _listener.openCamera();
                    },
                    onDoubleTap: () {},
                    child: roundedButton(
                      "Camera",
                      EdgeInsets.only(top: 10.0),
                      CommonColor.CHAT_SENDER_BOX,
                      Colors.white,
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      _listener.openGallery();
                    },
                    onDoubleTap: () {},
                    child: roundedButton(
                      "Gallery",
                      EdgeInsets.only(top: 10.0),
                      CommonColor.CHAT_SENDER_BOX,
                      Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  new GestureDetector(
                    onTap: () {
                      dismissDialog();
                      /*  if(!_isButtonTapped){
                        _isButtonTapped=true;
                        dismissDialog();
                      }*/
                    },
                    onDoubleTap: () {},
                    child: new Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: roundedButton(
                        "Cancel",
                        EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        CommonColor.CHAT_SENDER_BOX,
                        Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

/*Widget for camera,gallery rounded button*/
  Widget roundedButton(
      String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(100.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor,
            fontSize: buttonText,
            fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }
}
