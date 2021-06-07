import 'dart:io';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:post_app/Dialog/image_picker_handler.dart';
import 'package:post_app/Utils/AppPreference.dart';
import 'package:post_app/Utils/CommonColor.dart';
import 'package:post_app/Utils/String_En.dart';
import 'package:post_app/Utils/common_widget.dart';
import 'package:post_app/Utils/size_config.dart';

class MyPostScreen extends StatefulWidget {
  final String postImg;

  const MyPostScreen({
    Key key,
    this.postImg,
  }) : super(key: key);
  @override
  _MyPostScreenState createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen>
    with TickerProviderStateMixin, ImagePickerListener {
  int textLength = 0;
  File userProfileFile;
  ImagePickerHandler imagePicker;
  final _mobileFocus = new FocusNode();
  final _autotextController = TextEditingController();
  AnimationController _controller;
  bool isShowImage = false;
  String userProfile = "";
  String chooseImg = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                height: SizeConfig.screenHeight * 0.12,
                child: getAddTitleLayout(
                    SizeConfig.screenHeight, SizeConfig.screenWidth)),
            Divider(
              color: Colors.grey,
              height: 1,
            ),
            getProfileLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
            Container(
              height: SizeConfig.screenHeight * 0.15,
              child: getPostTextLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth),
            ),
            Container(
              height: SizeConfig.screenHeight * 0.55,
              child: getAddImageLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: SizeConfig.screenHeight * 0.05,
              child: getPhotoLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAddImageLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * .0),
      child: Container(
        height: parentHeight * .6,
        //width: parentWidth,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: isShowImage == false
              ? DecorationImage(
                  image: new NetworkImage(userProfile), fit: BoxFit.cover)
              : DecorationImage(
                  image: new FileImage(
                      userProfileFile != null ? userProfileFile : File("")),
                  fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget getAddTitleLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding:
          EdgeInsets.only(top: parentHeight * 0.05, left: parentWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: CommonColor.BLACK_COLOR,
                  size: parentHeight * 0.035,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: parentWidth * 0.04),
                child: Text(
                  StringEn.CREATE_POST,
                  style: CommonWidget.getAvenierHeavyTextStyle(
                      SizeConfig.blockSizeHorizontal * 4.8,
                      CommonColor.BLACK_COLOR,
                      FontWeight.w500),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: parentHeight * 0.05,
              width: parentHeight * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: CommonColor.ICON_BACKGROUND_COLOR,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: Center(
                child: Text(StringEn.POST,
                    style: CommonWidget.getAvenierHeavyTextStyle(
                        SizeConfig.blockSizeHorizontal * 4,
                        CommonColor.MAIN_BUTTON_COLOR,
                        FontWeight.w500)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getProfileLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: parentHeight * .05,
            width: parentHeight * .05,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //color: Colors.grey,
            ),
            child: Image(
              image: new AssetImage("images/user_placeholder.png"),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Payal Parmar",
              style: CommonWidget.getAvenierHeavyTextStyle(
                  SizeConfig.blockSizeHorizontal * 4,
                  CommonColor.BLACK_COLOR,
                  FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget getPostTextLayout(double parentHeight, double parentWidth) {
    return KeyboardAvoider(
      autoScroll: true,
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.03,
            left: parentWidth * 0.02,
            right: parentWidth * 0.02,
            bottom: parentHeight * 0.005),
        child: Center(
          child: SizedBox(
            height: parentHeight * 0.47,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: parentHeight * 0.0,
                    bottom: parentHeight * 0.008,
                    left: parentWidth * 0.03,
                    right: parentWidth * 0.03),
                child: AutoSizeTextField(
                  fullwidth: true,
                  autofocus: true,
                  presetFontSizes: [
                    14,
                    13,
                    12,
                    11,
                    10,
                    9,
                  ],
                  wrapWords: true,
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  focusNode: _mobileFocus,
                  controller: _autotextController,
                  style: TextStyle(
                      //fontFamily: fontFamilyStyle,
                      color: Colors.black),
                  maxLines: _autotextController.text.length < 670 ? null : 6,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(650),
                  ],
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.multiline,
                  cursorColor: CommonColor.TEXT_INACTIVE_COLOR,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    disabledBorder: InputBorder.none,
                    hintText: StringEn.TYPE_POST,
                    hintStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                      color: CommonColor.TEXT_INACTIVE_COLOR,
                      /* fontFamily: fontFamilyStyle*/
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getPhotoLayout(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: () {
        imagePicker.showDialog(context);
        print("imagepicker");
      },
      child: Padding(
        padding: EdgeInsets.only(top: parentHeight * 0.02),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.photo,
                color: Colors.green,
                size: parentHeight * 0.04,
              ),
              Padding(
                padding: EdgeInsets.only(left: parentWidth * 0.03),
                child: Text(
                  StringEn.PHOTOS,
                  style: CommonWidget.getAvenierHeavyTextStyle(
                      SizeConfig.blockSizeHorizontal * 4,
                      CommonColor.BLACK_COLOR,
                      FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  userImage(File _image, String _isFor) {
    print("image _image ....$_image");
    if (_image != null) if (mounted)
      setState(() {
        userProfileFile = _image;
        isShowImage = true;
        userProfile = _image.toString();
        print("image changes click ....$userProfile");
      });
  }
}
