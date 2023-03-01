import 'package:flutter/material.dart';
import 'package:music_player/constants/colors.dart';

const bold = "bold";
const regular = "regular";

ourStyle({double? size = 14}) {
  return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size,
      fontFamily: "bold",
      color: whiteColor);
}
