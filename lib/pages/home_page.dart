import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';
import 'package:hamosad_scouting_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double widgetSize = width < height ? width / 5 : height / 5;

    return Scaffold(
      appBar: PageAppBar(title: "", buttons: [
        IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              color: Colors.grey.shade600,
              size: 40,
            ),
            alignment: Alignment.center,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutPage())))
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create a\nnew report",
              textAlign: TextAlign.center,
              style: AppFont(size: widgetSize / 2, color: Colors.grey.shade700)
                  .getFont(),
            ),
            SizedBox(
              height: widgetSize / 5,
            ),
            IconButton(
              icon: const Icon(Icons.add_box_outlined),
              iconSize: widgetSize,
              color: Colors.grey.shade700,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GeneralInformationPage())),
            ),
          ],
        ),
      ),
    );
  }
}
