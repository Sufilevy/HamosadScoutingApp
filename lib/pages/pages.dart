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
export 'history_page.dart';
export 'pit_report.dart';
export 'pit_information.dart';
export 'help_page.dart';
export '../misc/lang.dart';

Color accentColor = Colors.green.shade700;
var pages = {};
bool creatingNewReport = true;
String reportId = "";
List<String> reports = [];
enum ReportType { game, pit }
ReportType reportType = ReportType.game;
ReportType lastReportType = ReportType.game;

class AppFont {
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final FontStyle? font;

  AppFont({this.color, this.size, this.fontWeight, this.font});

  dynamic getFont() {
    return GoogleFonts.abel(
      color: color ?? accentColor,
      fontSize: size,
      fontStyle: font,
      fontWeight: fontWeight,
    );
  }
}
