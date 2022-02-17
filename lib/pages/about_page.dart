import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Center(
              child: Text(
                "About",
                style: AppFont(
                  size: 23,
                ).getFont(),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: accentColor,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    SystemSound.play(SystemSoundType.click);
                  },
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "This app was made with",
                    textAlign: TextAlign.center,
                    style: AppFont(size: 22.5, color: Colors.grey.shade700)
                        .getFont(),
                  ),
                  const FlutterLogo(
                    size: 120,
                    style: FlutterLogoStyle.horizontal,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "This app was made by",
                      textAlign: TextAlign.center,
                      style: AppFont(size: 22.5, color: Colors.grey.shade700)
                          .getFont(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text("Sufi Levy",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.shadowsIntoLight(
                          textStyle: const TextStyle(
                              color: Color(0xFF165700),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "This app was made for",
                      textAlign: TextAlign.center,
                      style: AppFont(size: 22.5, color: Colors.grey.shade700)
                          .getFont(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Image(
                      width: 190.5,
                      height: 96.6,
                      image: AssetImage(
                          "assets/png/hamosad_logo_color_transperent.png"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
