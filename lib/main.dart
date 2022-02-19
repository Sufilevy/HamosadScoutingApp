import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/database.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  if (Platform.isWindows) {
    runApp(const WindowsApp());
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: "Scouting 1657",
      options: DefaultFirebaseOptions.currentPlatform,
    );
    getTeams();
    runApp(
      const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    pages = {
      "home": HomePage(),
    };

    return MaterialApp(
      title: "Scouting 1657",
      home: pages["home"],
      theme: ThemeData.dark(),
    );
  }
}

class WindowsApp extends StatelessWidget {
  const WindowsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Scouting 1657",
      home: Scaffold(
        body: Center(
          child: Text(
            "This app is not supported by Windows.\nYou can try it in Android, iOS and web.",
            style: AppFont(size: 45, fontWeight: FontWeight.bold).getFont(),
          ),
        ),
      ),
      theme: ThemeData.dark(),
    );
  }
}
