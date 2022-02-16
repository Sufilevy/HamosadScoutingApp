import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double widgetSize = width < height ? width / 5 : height / 5;

    return Scaffold(
      appBar: PageAppBar(title: "About", automaticallyImplyLeading: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "This app...",
              textAlign: TextAlign.center,
              style: AppFont(size: widgetSize / 4, color: Colors.grey.shade700)
                  .getFont(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Was made with",
                    textAlign: TextAlign.center,
                    style: AppFont(
                            size: widgetSize / 4, color: Colors.grey.shade700)
                        .getFont(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterLogo(
                    size: widgetSize,
                    style: FlutterLogoStyle.horizontal,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Was made by",
                    textAlign: TextAlign.center,
                    style: AppFont(
                            size: widgetSize / 4, color: Colors.grey.shade700)
                        .getFont(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterLogo(
                    size: widgetSize,
                    style: FlutterLogoStyle.horizontal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
