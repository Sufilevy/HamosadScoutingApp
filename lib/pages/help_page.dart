import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Center(
              child: Text(
                "Help",
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
    );
  }
}
