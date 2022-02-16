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

class AppFont {
  AppFont({Color? color, double? size})
      : _color = color,
        _size = size;

  final Color? _color;
  final double? _size;

  dynamic getFont() {
    return GoogleFonts.abel(
        textStyle: TextStyle(color: _color, fontSize: _size));
  }
}
