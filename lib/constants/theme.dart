import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors.
  static const headerColor = Color.fromARGB(255, 11, 132, 175);
  static const foregroundColor = Color(0xFFffffff);
  static const backgroundColor = Color(0xFFffffff);
  static const buttonPlay = headerColor;
  static const iconSideBar = Colors.white;

  // Constants for detailed customization.
  static const appBarColor = headerColor;
  static const appBarFontColor = foregroundColor;

  static const metadataColor = Color.fromARGB(255, 14, 190, 221);

  static const controlButtonColor = headerColor;
  static const buttonSplashColor = Color.fromARGB(255, 23, 176, 211);
  static const controlButtonIconColor = foregroundColor;

  //Volume
  static const iconVolume = Color.fromARGB(255, 23, 176, 211);
  static const activeColor = Color.fromARGB(255, 23, 176, 211);
  static const inactiveColor = Color(0xFFB7C3EC);
  static const thumbColor = Color.fromARGB(255, 23, 176, 211);

  //Social Network Home
  static const socialColor = Color.fromARGB(255, 23, 176, 211);

  static const artworkShadowColor = Color.fromARGB(47, 19, 168, 201);
  static const artworkShadowOffset = Offset(2.0, 2.0);
  static const artworkShadowRadius = 8.0;

  //About Us
  static const aboutUsTitleColor = headerColor;
  static const aboutUsDescriptionColor = headerColor;
  static const aboutUsFontColor = foregroundColor;
  static const aboutUsContainerTitleColor = Color.fromARGB(255, 23, 176, 211);
  static const aboutContainerBackgroundColor = headerColor;

  //Sleep Timer
  static const timerTrackColor = Color.fromARGB(255, 183, 20, 220);
  static final timerTrackInativeColor = headerColor.withOpacity(0.10);
  static const progressBarColor = Color.fromARGB(255, 182, 82, 205);
  static const shadowColor = Color.fromARGB(255, 211, 100, 236);
  static const controlColor = Color.fromARGB(255, 185, 22, 222);
}
