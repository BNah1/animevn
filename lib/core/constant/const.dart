import 'package:flutter/material.dart';


const double paddingSimple = 10;

const dColorMain = Color(0xff0EAF89);
const dColorIconButton = Colors.blue;
const sizeIconButton = 24.0;
const dColorFooterImage = Colors.white60;


TextStyle getText({
  Color color = Colors.white,
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.bold,
  FontStyle fontStyle = FontStyle.normal,
  double letterSpacing = 0,
  double wordSpacing = 0,
  TextDecoration decoration = TextDecoration.none,
  Color? decorationColor,
  double? height,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    decoration: decoration,
    decorationColor: decorationColor,
    height: height,
  );
}


const styleTileItem = TextStyle(
  color: Colors.white,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const styleTileAppbar = TextStyle(
  color: Colors.black,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

const styleTextInButton = TextStyle(
  color: Colors.black,
  fontSize: 17,
  fontWeight: FontWeight.bold,
);

const styleTile = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const styleTileIcon = TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

