import 'package:flutter/material.dart';

const dColorMain = Color(0xff0EAF89);
const dColorIconButton = Colors.blue;
const sizeIconButton = 24.0;
const dColorFooterImage = Colors.white60;

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
  color: Colors.black,
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

