// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get theme => ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      textTheme: GoogleFonts.poppinsTextTheme(),
    );

class ButtonStyles {
  static ButtonStyle primary = ButtonStyle(
    minimumSize: MaterialStateProperty.all(
      Size(MediaQuery.of(Get.context!).size.width * 0.8, 65),
    ),
    textStyle: MaterialStateProperty.all(
      Theme.of(Get.context!)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevation: MaterialStateProperty.all(0),
  );
}
