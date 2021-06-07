import 'package:flutter/material.dart';

class CommonWidget {
  static getAvenierLightTextStyle(double font, Color color, fontWeight) {
    return new TextStyle(
      fontSize: font,
      color: color,
      fontFamily: "Avenir_Light",
      fontWeight: fontWeight,
    );
  }

  static getAvenierHeavyTextStyle(double font, Color color, fontWeight) {
    return new TextStyle(
      fontSize: font,
      color: color,
      fontFamily: "Avenir_Heavy",
      fontWeight: fontWeight,
    );
  }

  static getAvenierBookTextStyle(double font, Color color, fontWeight) {
    return new TextStyle(
      fontSize: font,
      color: color,
      fontFamily: "Avenir_Book",
      fontWeight: fontWeight,
    );
  }
}
