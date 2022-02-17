library pages;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export 'home_page.dart';
export 'about_page.dart';
export 'general_information_page.dart';
export 'autonomus_page.dart';
export 'teleop_page.dart';
export 'endgame_page.dart';
export 'summary_page.dart';

Color accentColor = Colors.green.shade700;
Map<String, StatefulWidget> pages = {};

class AppFont {
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final FontStyle? font;

  AppFont({this.color, this.size, this.fontWeight, this.font});

  dynamic getFont() {
    return GoogleFonts.abel(
      textStyle: TextStyle(
          color: color ?? accentColor,
          fontSize: size,
          fontStyle: font,
          fontWeight: fontWeight),
    );
  }
}
